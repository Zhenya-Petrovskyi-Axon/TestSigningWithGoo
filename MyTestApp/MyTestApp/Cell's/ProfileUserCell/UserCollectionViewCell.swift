//
//  UserCollectionViewCell.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 04.06.2021.
//

import UIKit
import Kingfisher

struct ImageCell {
    let image: String
}

class ImageCellViewModel {
    let imageView: ImageCell
    init(imageView: ImageCell) {
        self.imageView = imageView
    }
}

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    var viewModel: ImageCellViewModel! {
        didSet {
            guard let url = URL(string: viewModel.imageView.image) else { return }
            userImage.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }
    
    func setupView() {
        userImage.layer.borderWidth = 0.8
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height / 2
    }
    
}
