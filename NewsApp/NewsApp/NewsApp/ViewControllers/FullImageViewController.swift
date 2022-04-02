//
//  FullImageViewController.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//

import UIKit
class FullImageViewController: UIViewController {
   
    //MARK: Outlets
    @IBOutlet weak var fullImageDisplay: UIImageView! {
        didSet{
            fullImageDisplay.contentMode = .scaleToFill
        }
    }
    @IBOutlet weak var likeBtn: UIButton!
    
    var receivedImage: URL?
    //Storing tap status
    var onTap = false {
        didSet{
            likeBtn.setTitle(onTap ? "Unlike" : "Like", for: .normal)
        }
    }
    
    var selectedArtical : ArticleViewModel?
    var delegate : ArticleCVCellDelegate?
    var selectedItemIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get status of like button
        if let likeStatus = selectedArtical?.likeStatus {
            onTap = likeStatus
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = receivedImage {
            
            URLSession.shared.dataTask(with: data) {[weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.fullImageDisplay.image = UIImage(data: data)
                }
            }.resume()
        }
        
    }
    
    @IBAction func onTapLikeBtn(_ sender: UIButton) {
        
        let likeStatus = selectedArtical?.likeStatus ?? false
        selectedArtical?.likeStatus = likeStatus ? false : true
        onTap = likeStatus ? false : true
        delegate?.updateLikeStatus(index: selectedItemIndex, Status: onTap)
    }

}
