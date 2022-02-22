//
//  CategoryListVC.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import UIKit

class CategoryListVC: UIViewController {

    @IBOutlet weak var dishListTV: UITableView!
    
    var dishCategory: DishCategory?
    var categoryList = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* //uncomment when not added in the StoryBoard
        dishListTV.delegate = self
        dishListTV.dataSource = self
         */
        title = dishCategory?.name
        registerCell()
    }
    
    private func registerCell() {
        dishListTV.register(DishListTVCell.nib(), forCellReuseIdentifier: DishListTVCell.identifier)
    }

}

extension CategoryListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: DishListTVCell.identifier, for: indexPath) as? DishListTVCell else {return UITableViewCell()}
        listCell.setUp(dish: categoryList[indexPath.row])
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailedVC.instanciate()
        controller.dish = categoryList[indexPath.row]
        show(controller, sender: self)
    }
    
}
