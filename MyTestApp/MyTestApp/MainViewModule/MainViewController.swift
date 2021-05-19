//
//  MainViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

class MainViewController: UIViewController, Storyboarded {
    
    var mainViewModel: MainViewModelProtocol? = MainViewModel()
    weak var coordinator: MainCoordinator?
    
    var logoutAction: (() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "You're in the app, Congratulations"
    }
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        logoutAction?()
    }
}
