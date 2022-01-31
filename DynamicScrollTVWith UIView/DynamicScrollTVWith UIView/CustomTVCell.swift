//
//  CustomTVCell.swift
//  DynamicScrollTVWith UIView
//
//  Created by apple on 10/05/21.
//

import UIKit

class CustomTVCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
