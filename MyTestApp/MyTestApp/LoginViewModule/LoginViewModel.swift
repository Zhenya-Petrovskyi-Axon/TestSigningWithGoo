//
//  LoginViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import Foundation
import GoogleSignIn

protocol LoginViewModelProtocol {
    var viewDidLoad: () { get set }
}

class LoginViewModel: LoginViewModelProtocol {
    var logedIn: () -> Void = { }
    
    var viewDidLoad: () = { }()
    
}
