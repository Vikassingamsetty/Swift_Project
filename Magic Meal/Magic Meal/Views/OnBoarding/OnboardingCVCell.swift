//
//  OnboardingCVCell.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCVCell.self)
    
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    
    func setUp(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
    
}
