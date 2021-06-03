//
//  CollectionViewCell.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 03.06.2021.
//

import UIKit
import Kingfisher

struct UsersCellModel {
    var image: String
    var label: String
}

class UserCellViewModel {
    let model: UsersCellModel
    init(model: UsersCellModel) {
        self.model = model
    }
}

class UserCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var viewModel: UserCellViewModel! {
        didSet {
            userName.text = viewModel.model.label
            if let url = URL(string: "\(viewModel.model.image)") {
                userImage.kf.setImage(with: url)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }

}

