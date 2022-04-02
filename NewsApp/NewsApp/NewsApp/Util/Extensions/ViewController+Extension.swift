//
//  ViewController+Extension.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func toastMessage(_ message: String){
        let keysWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        guard let window = keysWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            UIView.animate(withDuration: 2, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
            }
        }
    }
    
    
    //MARK: Storyboard initialization
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instanciate() ->  Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
    
}
