//
//  listTVCell.swift
//  CVInsideTV
//
//  Created by Singamsetty Vikas on 13/02/22.
//

import UIKit

class listTVCell: UITableViewCell {

    static var identifier = String(describing: listTVCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: listTVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var imageCV: UICollectionView!
    
    let localImages: [String] = ["image1","image2","image3","image4"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCV.delegate = self
        imageCV.dataSource = self
        imageCV.register(listImageCVCell.nib(), forCellWithReuseIdentifier: listImageCVCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension listTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCV.dequeueReusableCell(withReuseIdentifier: listImageCVCell.identifier, for: indexPath) as? listImageCVCell else {return UICollectionViewCell()}
        cell.configView(image: localImages[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsForWidth:CGFloat = 2.0
        
        let availableWidth = imageCV.bounds.size.width
        let minWidth = floor(availableWidth/cellsForWidth)
        let reminder = availableWidth - minWidth * cellsForWidth
        let colomIndex = CGFloat(indexPath.row).truncatingRemainder(dividingBy: CGFloat(cellsForWidth)) < reminder ? minWidth+1 : minWidth
        
        return CGSize(width: colomIndex, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        //webgentechnology
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            let cell = self.imageCV.cellForItem(at: indexPath) as! listImageCVCell
            cell.offerImages.transform = .init(scaleX: 0.8, y: 0.8)
            cell.backView.alpha = 1
        }, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            
            let cell = self.imageCV.cellForItem(at: indexPath) as! listImageCVCell
            cell.offerImages.transform = .identity
            cell.backView.alpha = 0
            
        }, completion: nil)
        
    }

}
