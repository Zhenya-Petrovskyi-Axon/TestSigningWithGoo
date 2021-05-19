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
    var loginAction: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
        isUserCurrent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewPresenter()
        setupButton()
        titleLabel.text = "Hello User"
        loginAction?()
    }
    
    func isUserCurrent() {
        GIDSignIn.sharedInstance().restorePreviousSignIn()
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
    
}

