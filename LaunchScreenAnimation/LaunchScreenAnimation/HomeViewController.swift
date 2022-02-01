//
//  HomeViewController.swift
//  LaunchScreenAnimation
//
//  Created by apple on 02/04/21.
//

import UIKit

class HomeViewController: UIViewController {

    private var titleLbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Welcome to the wold of Dark"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.frame = CGRect(x: 10, y: 250, width: view.frame.size.width - 20, height: 70)
        view.backgroundColor = .link
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(titleLbl)
        
        //titleLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
    }
    
    
}
