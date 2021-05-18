//
//  ViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: LoginViewModelProtocol! = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewPresenter()
        setupButton()
        titleLabel.text = "Hello User"
    }
    
    func setupButton() {
        signInButton.layer.cornerRadius = 10
        signInButton.layer.masksToBounds = true
        signInButton.backgroundColor = .systemGray
        signInButton.colorScheme = .dark
        signInButton.style = .wide
    }
    
    func loginViewPresenter() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        viewModel.signOut()
    }
}

