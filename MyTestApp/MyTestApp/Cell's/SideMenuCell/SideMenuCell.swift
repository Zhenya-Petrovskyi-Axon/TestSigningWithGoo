//
//  SideMenuCell.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

struct MenuCellModel {
    var icon: UIImage
    var title: String
}

class MenuCellViewModel {
    let menuModel: MenuCellModel
    init(menuModel: MenuCellModel) {
        self.menuModel = menuModel
    }
}

class SideMenuCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    var viewModel: MenuCellViewModel! {
        didSet {
            cellImageView.image = viewModel.menuModel.icon
            cellLabel.text = viewModel.menuModel.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        backgroundColor = .clear
        cellImageView.tintColor = .white
        self.cellLabel.textColor = .white
    }
    
}
