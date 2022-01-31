//
//  MyOwnTableView.swift
//  DynamicScrollTVWith UIView
//
//  Created by apple on 19/05/21.
//

import UIKit

class MyOwnTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
