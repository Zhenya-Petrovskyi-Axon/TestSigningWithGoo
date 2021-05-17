//
//  ViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
      super.viewDidLoad()
        signingInstance()
        setupButton()
        titleLabel.text = "Hello User"
        
    }

    func setupButton() {
        signInButton.layer.cornerRadius = 10
        signInButton.layer.masksToBounds = true
        signInButton.backgroundColor = .systemGray
    }
    
    func signingInstance() {
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }

}

