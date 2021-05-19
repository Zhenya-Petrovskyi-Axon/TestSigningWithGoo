//
//  MainViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

protocol MainViewModelProtocol {
    func logout()
}

class MainViewModel: MainViewModelProtocol {
    
    var coordinator: CoordinatorProtocol?
    
    init() {
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
    }
    
    func logout() {
        GIDSignIn.sharedInstance().signOut()
    }
}
