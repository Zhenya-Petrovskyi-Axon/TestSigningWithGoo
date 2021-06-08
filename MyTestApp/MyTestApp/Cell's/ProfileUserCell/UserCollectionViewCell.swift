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
    @IBOutlet weak var underImageView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    var viewModel: ImageCellViewModel! {
        didSet {
            guard let url = URL(string: viewModel.imageView.image) else { return }
            userImage.kf.setImage(with: url)
        }
    }
    
    override func layoutSubviews() {
        setupView()
    }
    
    func setupView() {
        userImage.layer.borderWidth = 0.8
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height / 2
        underImageView.layer.borderWidth = 0.8
        underImageView.layer.borderColor = UIColor.black.cgColor
        underImageView.layer.masksToBounds = true
        underImageView.layer.cornerRadius = underImageView.frame.height / 2
        underImageView.addShadow(offset: CGSize.init(width: 15,height: 8),
                                 color: .black,
                                 radius: 4,
                                 opacity: 0.4)
    }
}
