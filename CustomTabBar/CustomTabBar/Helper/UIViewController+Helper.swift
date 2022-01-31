//
//  UIViewController+Helper.swift
//  CustomTabBar
//
//  Created by apple on 17/05/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    var rootVC: RootStackTabViewController? {
        var selfVC = self
        while let parentVC = selfVC.parent {
            if let vc = parentVC as? RootStackTabViewController {
                return vc
            } else {
                selfVC = parentVC
            }
        }
        return nil
    }
    
}
