//
//  ArticleCVCell.swift
//  NewsApp
//
//  Created by Singamsetty Vikas on 01/04/22.
//
import Foundation
import UIKit

@objc protocol ArticleCVCellDelegate {
    func selectdItemLikeStatus(index: Int)
    @objc func updateLikeStatus(index: Int, Status: Bool)
}

class ArticleCVCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: ArticleCVCell.identifier, bundle: nil)
    }
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var publishedLblLocal: UILabel!
    @IBOutlet weak var publishedLblUTC: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var likeDislikeImage: UIImageView!
    @IBOutlet weak var likeDislikeView: UIControl!
    @IBOutlet weak var mainView: UIView!{
        didSet{
            mainView.layer.cornerRadius = 20
        }
    }
    
    var delegate: ArticleCVCellDelegate?
    
    var selectedBtn = false{
        didSet{
            likeDislikeImage.image = UIImage(systemName: selectedBtn ? Constants.thumsUpFillImage : Constants.thumsUpImage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLbl.text = nil
        publishedLblUTC.text = nil
        publishedLblLocal.text = nil
        descriptionLbl.text = nil
        mainImage.image = nil

    }
    
    func configDataToCell(_ viewModel: ArticleViewModel) {
        titleLbl.text = "Title: \(viewModel.title ?? "NO DATA")"
        publishedLblLocal.text = "Local Published Date: \((viewModel.publishedAt ?? "NO DATA").dateToString())"
        publishedLblUTC.text = "UTC Published Date: \((viewModel.publishedAt ?? "NO DATA").convertToUTC())"
        self.selectedBtn = viewModel.likeStatus ?? false

        //convert to data -> UIImage
        if let data = viewModel.imageData {
            mainImage.image = UIImage(data: data)
        }else if let url = viewModel.imageURL{
            
            URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.mainImage.image = UIImage(data: data)
                }
            }.resume()
            
        }
        
        descriptionLbl.text = "Description: \(viewModel.description ?? "NO DATA")"
    }
    
    @IBAction func onTapLikeView(_ sender: UIButton) {
        delegate?.selectdItemLikeStatus(index: sender.tag)
    }
    
}

