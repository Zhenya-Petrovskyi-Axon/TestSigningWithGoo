//
//  ViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

protocol LoginViewControllerDelegate: AnyObject {
    func loginSuccess()
}

class LoginViewController: UIViewController, Storyboarded {
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var titleLabel: UILabel!
    var viewModel: LoginViewModelProtocol!
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompletions()
        loginViewPresenter()
        setupButton()
        titleLabel.text = "Hello User"
    }
    
    func setupCompletions() {
        viewModel.onLogedIn = {
            self.delegate?.loginSuccess()
        }
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

