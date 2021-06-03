//
//  LoginViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import Foundation
import GoogleSignIn

protocol LoginViewModelProtocol {
    var onLogedIn: () -> Void { get set }
}

class LoginViewModel: LoginViewModelProtocol {
    var onLogedIn = { }
    var service: GoogleSignInService
    
    init(service: GoogleSignInService) {
        self.service = service
        service.completion = { [weak self] user, error in
            if error != nil {
                print("Nope")
            } else {
                self?.onLogedIn()
                print("Loged In successfully")
            } 
        }
    }
}
