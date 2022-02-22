//
//  DishDetailedVC.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import UIKit
//import ProgressHUD

class DishDetailedVC: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeOrderBtn: UIButton!
    
    var dish: Dish?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDishDetails()
    }
    
    func setUpDishDetails() {
        dishImageView.image = UIImage(named: dish?.image ?? "")
        titleLbl.text = dish?.name
        caloriesLbl.text = dish?.formattedCalories
        descriptionLbl.text = dish?.description
    }
    
    
    @IBAction func onTapPlaceOrder(_ sender: UIButton) {
        
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else{
//            ProgressHUD.showError("Enter your name")
            return
        }
        
//        ProgressHUD.show()
        NetworkService.shared.placeOrder(dishID: dish?.id ?? "", name: name) { result in
            switch result {
                
            case .success(_):
                print("Your order is placed")
//                ProgressHUD.showSuccess("Your order has been placed")
            case .failure(let error):
                print(error.localizedDescription)
//                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
}
