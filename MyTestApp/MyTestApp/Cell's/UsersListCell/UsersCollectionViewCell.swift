//
//  UsersCollectionViewCell.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 03.06.2021.
//

import UIKit

struct UsersCellModel {
    var image: UIImage
    var label: String
}

class UserCellViewModel {
    let model: UsersCellModel
    init(model: UsersCellModel) {
        self.model = model
    }
}

class UsersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    private(set) var viewModel: UserCellViewModel! {
        didSet {
            userFullNameLabel.text = viewModel.model.label
            userImageView.image = viewModel.model.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
