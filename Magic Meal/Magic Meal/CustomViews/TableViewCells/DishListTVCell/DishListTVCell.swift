//
//  DishListTVCell.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import UIKit

class DishListTVCell: UITableViewCell {

    static let identifier = String(describing: DishListTVCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: DishListTVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
   
    func setUp(dish: Dish) {
        dishImageView.image = UIImage(named: dish.image ?? "No Image")
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
    }
    
    func setUp(orders: Order) {
        dishImageView.image = UIImage(named: orders.dish?.image ?? "")
        dishImageView.contentMode = .scaleAspectFill
        titleLbl.text = orders.dish?.name
        descriptionLbl.text = orders.dish?.description
    }
   
}
