//
//  CardView.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initalViewSetUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initalViewSetUp()
    }
    
    private func initalViewSetUp() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.1
        layer.cornerRadius = 10
        layer.shadowRadius = 10
        cornerRadius = 10
    }
    
}
