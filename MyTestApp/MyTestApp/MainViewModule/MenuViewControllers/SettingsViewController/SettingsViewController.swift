//
//  PinkViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

protocol SettingsViewControllerLogoutDelegate: AnyObject {
    func logout()
}

class SettingsViewController: BaseViewController, Storyboarded {
    weak var delegate: SettingsViewControllerLogoutDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        delegate?.logout()
    }
    
}
