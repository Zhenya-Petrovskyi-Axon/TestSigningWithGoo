//
//  MainTableViewCell.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 21.05.2021.
//

import UIKit

struct TeamCellModel {
    var fullName: String
    var cityName: String
    var devisionName: String
}

class TeamCellViewModel {
    let teamCellModel: TeamCellModel
    init(teamModel: TeamCellModel) {
        self.teamCellModel = teamModel
    }
}

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var underLabelView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var devisionNameLabel: UILabel!
    
    var viewModel: TeamCellViewModel! {
            didSet {
                fullNameLabel.text = viewModel.teamCellModel.fullName
                cityNameLabel.text = viewModel.teamCellModel.cityName
                devisionNameLabel.text = viewModel.teamCellModel.devisionName
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        underLabelView.layer.masksToBounds = true
        underLabelView.layer.cornerRadius = 8
        underLabelView.layer.borderWidth = 0.8
        underLabelView.layer.borderColor = UIColor.systemGray.cgColor
        
    }
}

