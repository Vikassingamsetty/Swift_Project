//
//  HomeVC.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var popularDishesCV: UICollectionView!
    @IBOutlet weak var chefSpecialCV: UICollectionView!
    
    var categories: [DishCategory] = [.init(id: "1", name: "Africa Dish", image: "image1"),
                                      .init(id: "2", name: "Africa Dish 2", image: "image2"),.init(id: "3", name: "Africa Dish 3", image: "image3"),.init(id: "4", name: "Africa Dish 4", image: "image4"),.init(id: "5", name: "Africa Dish 5", image: "image5")]
    
    var popularDish: [Dish] = [
        .init(id: "2", name: "Faray", description: "Nice roasted items in the dish to be accomplished", image: "image3", calorie: 40.897869),
        .init(id: "1", name: "Chiyano", description: "Fav Dish is here", image: "image4", calorie: 20.897869),
        .init(id: "2", name: "Fercanius", description: "This is the best I have ever had", image: "image2", calorie: 40.897869)
    ]
    
     var specialDish: [Dish] = [
        .init(id: "1", name: "No Meal to deal", description: "This is the best I have ever had", image: "image1", calorie: 20.897869),
        .init(id: "2", name: "Faray", description: "This is the best I have ever had This is the best", image: "image3", calorie: 40.897869),
        .init(id: "3", name: "Sanayo", description: "This is the best I have ever had This is the best", image: "image5", calorie: 4.869)
     ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*//Uncomment if these are not declared in storyboard
        categoryCV.delegate = self
        categoryCV.dataSource = self
        popularDishesCV.delegate = self
        popularDishesCV.dataSource = self
         */
        chefSpecialCV.delegate = self
        chefSpecialCV.dataSource = self
         
        registerCells()
        
        NetworkService.shared.request(route: .temp, method: .get, parameters: nil, type: String.self, completion: {_ in })
    }
    
    private func registerCells() {
        
        categoryCV.register(CategoryCVCell.nib(), forCellWithReuseIdentifier: CategoryCVCell.identifier)
        popularDishesCV.register(DishesCVCell.nib(), forCellWithReuseIdentifier: DishesCVCell.identifier)
        chefSpecialCV.register(ChefsCVCell.nib(), forCellWithReuseIdentifier: ChefsCVCell.identifier)
    }
   
}

//MARK:- Extension Collection View Delegate & Data Source
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCV:
            return categories.count
        case popularDishesCV:
            return popularDish.count
        case chefSpecialCV:
            return specialDish.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case categoryCV:
            guard let categoryCell = categoryCV.dequeueReusableCell(withReuseIdentifier: CategoryCVCell.identifier, for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
            categoryCell.setUp(categories[indexPath.item])
            return categoryCell
        
        case popularDishesCV:
            guard let popularCell = popularDishesCV.dequeueReusableCell(withReuseIdentifier: DishesCVCell.identifier, for: indexPath) as? DishesCVCell else {return UICollectionViewCell()}
            popularCell.setUp(_dish: popularDish[indexPath.item])
            return popularCell
            
        case chefSpecialCV:
            guard let specialCell = chefSpecialCV.dequeueReusableCell(withReuseIdentifier: ChefsCVCell.identifier, for: indexPath) as? ChefsCVCell else {return UICollectionViewCell()}
            specialCell.setUp(_dish: specialDish[indexPath.item])
            return specialCell
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == categoryCV {
            let controller = CategoryListVC.instanciate()
            controller.categoryList = popularDish
            controller.dishCategory = categories[indexPath.item]
            show(controller, sender: self)
        }else{
            let controller = DishDetailedVC.instanciate()
            controller.dish = collectionView == popularDishesCV ? popularDish[indexPath.item] : specialDish[indexPath.item]
            show(controller, sender: self)
        }
        
    }
    
}
