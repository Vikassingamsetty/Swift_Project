//
//  UIView+Extension.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get{
            return self.cornerRadius
        }
        set{
            return self.layer.cornerRadius = newValue
        }
    }
}
