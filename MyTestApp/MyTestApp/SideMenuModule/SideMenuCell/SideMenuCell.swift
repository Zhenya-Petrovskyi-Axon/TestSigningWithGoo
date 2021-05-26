//
//  SideMenuCell.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class SideMenuCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
//    class var identifier: String { String(describing: self) }
//    class var nib: UINib { UINib(nibName: identifier, bundle: nil) }
    
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
