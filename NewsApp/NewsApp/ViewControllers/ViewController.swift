//
//  ViewController.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var switchButton: UIBarButtonItem!
    
    var gridFlowLayout = GridFlowLayout()
    var listFlowLayout = ListFlowLayout()
    
    private var modelData = [ArticleViewModel]()
    
    private var toggleSwitch = false {
        didSet{
            switchButton.title = self.toggleSwitch ? "Grid Mode" : "List Mode"
            updateButtonAppearance()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCV()
        getServerData()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(longPress)
    }
    
    func setUpCV() {
        collectionView.collectionViewLayout = listFlowLayout
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    fileprivate func updateButtonAppearance() {
    
        let layout = toggleSwitch ? gridFlowLayout : listFlowLayout
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    func getServerData() {
        APIService.shared.getAppleArticles(with: Constants.appleArticlesURL.asURL) {[weak self] result in
            switch result {
            case .success(let articles):
                print(articles.count)
                
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCVCell.identifier, for: indexPath) as? ArticleCVCell else{return UICollectionViewCell()}
        cell.configDataToCell(modelData[indexPath.item])
        cell.likeDislikeView.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullImgVC = FullImageViewController.instanciate()
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

