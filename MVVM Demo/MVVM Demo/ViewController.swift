//
//  ViewController.swift
//  MVVM Demo
//
//  Created by Singamsetty Vikas on 06/11/21.
//

import UIKit

extension String {
    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}

struct Details {
    var name:String
    var age: Int
    var address: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var table: UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .singleLine
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    var userDataModel = DataViewModel()
    var detailsModel: ContactModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func fetchUser() {
        
//        userDataModel.userNamesViewModel { [weak self] _ in
//            self?.table.reloadData()
//        }
       
        userDataModel.contactsData { [weak self] data, err in
            
            if err != nil {
                print("error while getting data")
                return
            }
            guard let data = data else {return}
            self?.detailsModel = data
            
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        table.delegate = self
        table.dataSource = self
        view.addSubview(table)
        table.frame = view.bounds
        fetchUser()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsModel?.contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = detailsModel?.contacts?[indexPath.row].email
        cell.detailTextLabel?.text = detailsModel?.contacts?[indexPath.row].gender
        return cell
    }
    
}

