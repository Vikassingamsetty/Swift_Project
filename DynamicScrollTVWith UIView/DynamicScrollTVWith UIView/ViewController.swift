//
//  ViewController.swift
//  DynamicScrollTVWith UIView
//
//  Created by apple on 10/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: MyOwnTableView!
    @IBOutlet weak var tbl_height:NSLayoutConstraint!
    @IBOutlet weak var viewHeight:NSLayoutConstraint!
    
    var sampleheight = CGFloat()
    
    var sampleText = "The Apple Store online is the most convenient destination to shop for Apple products, with online Apple Specialists available to help with anything from custom-configuring any Mac to setting up new devices. ... Students can shop for a Mac or iPad with special pricing, and receive discounts on accessories and AppleCare"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.isScrollEnabled = false
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tbl_height.constant = table.contentSize.height
        viewHeight.constant = 500 + tbl_height.constant
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CustomTVCell") as! CustomTVCell
        cell.titleLbl.numberOfLines = 0
        if indexPath.row % 2 == 0 {
            cell.titleLbl.text = sampleText
        }else{
            cell.titleLbl.text = "Sections of the row \(indexPath.row)"
        }
        
        return cell
    }
    
}

