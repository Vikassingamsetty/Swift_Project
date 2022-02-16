//
//  ViewController.swift
//  CVInsideTV
//
//  Created by Singamsetty Vikas on 13/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var refresher: UIRefreshControl = {
        let refreshController = UIRefreshControl()
        refreshController.tintColor = .white
        refreshController.backgroundColor = .gray
        refreshController.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshController
    }()
    
    @IBOutlet weak var listTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTV.register(listTVCell.nib(), forCellReuseIdentifier: listTVCell.identifier)
        listTV.refreshControl = refresher
    }
    
    @objc func pullToRefresh() {
        var timer = Timer()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { completed in
            timer.invalidate()
            self.refresher.endRefreshing()
        }
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTV.dequeueReusableCell(withIdentifier: listTVCell.identifier, for: indexPath) as? listTVCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}

