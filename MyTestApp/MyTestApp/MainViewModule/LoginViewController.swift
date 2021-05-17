//
//  ViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
        signingInstance()
    }

    func signingInstance() {
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }

}

