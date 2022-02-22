//
//  OrderListVC.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import UIKit

class OrderListVC: UIViewController {

    @IBOutlet weak var orderListTV: UITableView!
    
    var orderListModel: [Order] = [
        .init(id: "id", name: "SampleName", dish: .init(id: "id1", name: "Rice", description: "This is rice is from rajasthan", image: "image2", calorie: 34.0101)),
        .init(id: "id", name: "DoubleName", dish: .init(id: "id2", name: "Platter", description: "May Varieties are available in platter ", image: "image4", calorie: 34.0101)),
        .init(id: "id", name: "TrippleName", dish: .init(id: "id1", name: "Buffet", description: "Buffet has plenty of dishes", image: "image5", calorie: 34.0101))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        orderListTV.delegate = self
        orderListTV.dataSource = self
         */
        title = "Orders"
        registerCell()
    }
    
    func registerCell() {
        orderListTV.register(DishListTVCell.nib(), forCellReuseIdentifier: DishListTVCell.identifier)
    }

}

extension OrderListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: DishListTVCell.identifier, for: indexPath) as? DishListTVCell else {return UITableViewCell()}
        listCell.setUp(orders: orderListModel[indexPath.row])
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailedVC.instanciate()
        controller.dish = orderListModel[indexPath.row].dish
        show(controller, sender: self)
    }
    
}
