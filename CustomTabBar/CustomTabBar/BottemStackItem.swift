//
//  BottemStackItem.swift
//  CustomTabBar
//
//  Created by apple on 17/05/21.
//

import UIKit

class BottomStackItem {
    
    var title: String
    var image: String
    var isSelected: Bool
    
    init(title: String,
         image: String,
         isSelected: Bool = false) {
        self.title = title
        self.image = image
        self.isSelected = isSelected
    }
    
}
