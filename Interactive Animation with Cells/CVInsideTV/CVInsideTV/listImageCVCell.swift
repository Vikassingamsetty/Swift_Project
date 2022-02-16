//
//  listImageCVCell.swift
//  CVInsideTV
//
//  Created by Singamsetty Vikas on 13/02/22.
//

import UIKit

class listImageCVCell: UICollectionViewCell {

    static let identifier = String(describing: listImageCVCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: listImageCVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var offerImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configView(image: String) {
        offerImages.contentMode = .scaleAspectFill
        offerImages.image = UIImage(named: image)
    }
    
}
