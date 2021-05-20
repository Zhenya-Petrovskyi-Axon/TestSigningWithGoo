//
//  MainViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

protocol MainViewModelDlelegate {
    func logout()
}

protocol MainViewModelProtocol {
    func logout()
    var onLogout: () -> Void { get set }
}

class MainViewModel: MainViewModelProtocol {
    var onLogout = { }
    let service: GoogleSignInService
    init(service: GoogleSignInService) {
        self.service = service
    }
    
    func logout() {
        service.logout(completion: onLogout)
    }
}
