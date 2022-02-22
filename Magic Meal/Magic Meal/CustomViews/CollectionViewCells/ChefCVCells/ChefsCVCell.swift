//
//  ChefsCVCell.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 26/01/22.
//

import UIKit

class ChefsCVCell: UICollectionViewCell {
    
    static let identifier = String(describing: ChefsCVCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: ChefsCVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(_dish dish: Dish) {
        dishImageView.image = UIImage(named: dish.image ?? "")
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }

}
