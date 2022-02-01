//
//  UIExtensions.swift
//  InstagramSearchLayout
//
//  Created by Singamsetty Vikas on 31/01/22.
//

import UIKit

//MARK:- UIColor Extension
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.4...1), green: .random(in: 0.4...1), blue: .random(in: 0.4...1), alpha: 1)
    }
}

//MARK:- UIView Extension
extension UIView {
    
    //Adding view and constrains as needed
    func add(viewName: UIView, top:CGFloat, bottom:CGFloat, left:CGFloat, right:CGFloat) {
        
        viewName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewName)
        
        NSLayoutConstraint.activate([
            viewName.topAnchor.constraint(equalTo: self.topAnchor, constant: top),
            viewName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom),
            viewName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: left),
            viewName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: right)
        ])
        
    }
}
