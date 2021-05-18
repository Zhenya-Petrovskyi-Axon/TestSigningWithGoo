//
//  MainCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController = UINavigationController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
            let vc = MainViewController.instantiate()
            navigationController.pushViewController(vc, animated: false)
        } else {
            let vc = LoginViewController.instantiate()
            navigationController.pushViewController(vc, animated: false)
        }
    }
}
