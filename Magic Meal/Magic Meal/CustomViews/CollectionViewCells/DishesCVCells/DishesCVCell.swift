//
//  DishesCVCell.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit

class DishesCVCell: UICollectionViewCell {

    static var identifier = String(describing: DishesCVCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: DishesCVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setUp(_dish dish: Dish) {
        titleLbl.text = dish.name
        dishImageView.image = UIImage(named: dish.image ?? "")
        caloriesLbl.text = dish.formattedCalories
        descriptionLbl.text = dish.description
    }

}
