//
//  MainCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

class MainCoordinator: CoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController = UINavigationController()
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        GIDSignIn.sharedInstance().restorePreviousSignIn()
        if GIDSignIn.sharedInstance().hasPreviousSignIn() == false {
            let vc = LoginViewController.instantiate()
            navigationController.setViewControllers([vc], animated: true)
        } else {
            let vc = MainViewController.instantiate()
            vc.logoutAction = { [weak self] in
                GIDSignIn.sharedInstance().signOut()
                self?.rootLoginVC()
            }
            navigationController.setViewControllers([vc], animated: true)
        }
    }
    
    func logoutSuccess() {
//        GIDSignIn.sharedInstance().signOut()
//        let vc = MainViewController.instantiate()
        
    }
    
    func rootLoginVC() {
        let vcToPresent = LoginViewController.instantiate()
        navigationController.setViewControllers([vcToPresent], animated: true)
    }
}
