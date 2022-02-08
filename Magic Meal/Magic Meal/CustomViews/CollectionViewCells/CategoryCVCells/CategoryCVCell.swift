//
//  CategoryCVCell.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit
import Kingfisher

class CategoryCVCell: UICollectionViewCell {

    static let identifier = String(describing: CategoryCVCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: CategoryCVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    
    func setUp(_ category: DishCategory) {
        
        categoryTitleLbl.text = category.name
        categoryImageView.image = UIImage(named: category.image ?? "")
        categoryImageView.contentMode = .scaleAspectFill
    }

}
