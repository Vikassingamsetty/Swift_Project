//
//  ViewController.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchButton: UIBarButtonItem!
    //MARK: Initialize collectionview Layouts
    var gridFlowLayout = GridFlowLayout()
    var listFlowLayout = ListFlowLayout()
    //MARK: Instance of model
    private var modelData = [ArticleViewModel]()
    
    private var toggleSwitch = false {
        didSet{
            switchButton.title = self.toggleSwitch ? "Grid Mode" : "List Mode"
            updateButtonAppearance()
        }
    }
    
    //MARK: Viewlifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        getServerData()
        
        //Adding logpress to collectionview cells
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    //Config collection view
    func setUpCV() {
        collectionView.collectionViewLayout = listFlowLayout
        collectionView.register(ArticleCVCell.nib(), forCellWithReuseIdentifier: ArticleCVCell.identifier)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.collectionView)
            
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                if let cell = collectionView.cellForItem(at: indexPath) as? ArticleCVCell{
                    UIPasteboard.general.image = cell.mainImage.image
                    toastMessage("Image copied to clipboard")
                }
            }
        }
    }
    
    @IBAction func onTapSwitch(_ sender: Any) {
        toggleSwitch = !toggleSwitch
    }
    //CVLayout changes as of user selection
    fileprivate func updateButtonAppearance() {
        let layout = toggleSwitch ? gridFlowLayout : listFlowLayout
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
}

//MARK: API call to get server data
extension ViewController {
    func getServerData() {
        APIService.shared.getAppleArticles(with: Constants.appleArticlesURL.asURL) {[weak self] result in
            switch result {
            case .success(let articles):
                print(articles.count)
                //appending data to model
                self?.modelData.append(contentsOf: articles.compactMap({
                    ArticleViewModel(title: $0.title, description: $0.description, publishedAt: $0.publishedAt, imageURL: URL(string: $0.urlToImage ?? ""))
                }))
          
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Unable to retrive data \(error.localizedDescription)")
            }
        }
    }
}

//MARK: Collection view delegate & datasource
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCVCell.identifier, for: indexPath) as? ArticleCVCell else{return UICollectionViewCell()}
        cell.delegate = self
        cell.configDataToCell(modelData[indexPath.item])
        cell.likeDislikeView.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullImgVC = FullImageViewController.instanciate()
        fullImgVC.selectedArtical = modelData[indexPath.row]
        fullImgVC.receivedImage = modelData[indexPath.row].imageURL
        navigationController?.pushViewController(fullImgVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = modelData.count - 1
        if indexPath.row == lastItem {
            toastMessage("Loading NextPage")
            getServerData()
        }
    }
    
}

//MARK: Protocol extensions to update info
extension ViewController: ArticleCVCellDelegate {
    //updating like status of an image 
    func updateLikeStatus(index: Int, Status: Bool) {
        self.modelData[index].likeStatus = Status
    }
    
    func selectdItemLikeStatus(index: Int) {
        let likeStatus =  self.modelData[index].likeStatus ?? false
        self.modelData[index].likeStatus = likeStatus ? false : true
        self.collectionView.reloadData()
    }
    
}
