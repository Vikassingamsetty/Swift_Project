//
//  ViewController.swift
//  LaunchScreenAnimation
//
//  Created by apple on 02/04/21.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = #imageLiteral(resourceName: "icon")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.animate()
        }
    }
    
    func animate() {
        
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 3
            let diffx = size - self.view.frame.size.width
            let diffy = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(x: -(diffx/2), y: diffy/2, width: size, height: size)
        }
       
        UIView.animate(withDuration: 1.5) {
            self.imageView.alpha = 0
        } completion: { (finished) in
            if finished {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    let viewController = HomeViewController()
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                }
            }
        }
        
    }


}

