//
//  FullImageViewController.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//

import UIKit

class FullImageViewController: UIViewController {

    @IBOutlet weak var fullImageDisplay: UIImageView! {
        didSet{
            fullImageDisplay.contentMode = .scaleToFill
        }
    }
    @IBOutlet weak var likeBtn: UIButton!
    
    var receivedImage: URL?
    
    var onTap = false {
        didSet{
            likeBtn.setTitle(onTap ? "Unlike" : "Like", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let data = receivedImage {
            print(data)
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
        onTap = !onTap
        print(sender.tag, "Tag")
    }

}
