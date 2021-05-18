//
//  LoginViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import Foundation
import GoogleSignIn

protocol LoginViewModelProtocol {
    func signOut()
    var viewDidLoad: () { get set }
}

class LoginViewModel: LoginViewModelProtocol {
    var logedIn: () -> Void = { }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
        print("Successfuly signed out ")
    }
    
    var viewDidLoad: () = { }()
    
}
