//
//  MainCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

// MARK: - Main Coordinator Class
class AppCoordinator: CoordinatorProtocol {
    let service = GoogleSignInService()
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        service.setup()
    }
    
    // MARK: - App delegate flow handler
    func start() {
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
            goToMainFlow()
        } else {
            goToLoginFlow()
        }
    }
}

// MARK: - Default Coordinator functions
extension AppCoordinator {
    func goToMainFlow() {
        childCoordinators.removeAll()
        let coordinator = MainFlowCoordinator(navigationController: navigationController, service: service)
        coordinator.delegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goToLoginFlow() {
        childCoordinators.removeAll()
        let coordinator = LoginFlowCoordinator(navigationController: navigationController, service: service)
        coordinator.delegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: LoginFlowCoordinatorDelegate, MainFlowCoordinatorDelegate {
    // MARK : - Login flow delegate
    func didLogin() {
        goToMainFlow()
    }
    
    // MARK: - Main flow delegate
    func didLogout() {
        goToLoginFlow()
    }
}
