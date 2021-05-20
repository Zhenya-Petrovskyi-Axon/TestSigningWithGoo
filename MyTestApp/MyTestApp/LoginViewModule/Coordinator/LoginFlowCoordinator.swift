//
//  LoginFlowCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 20.05.2021.
//

import UIKit

protocol LoginFlowCoordinatorDelegate: AnyObject {
    func didLogin()
}

class LoginFlowCoordinator: CoordinatorProtocol, LoginViewControllerDelegate {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    weak var delegate: LoginFlowCoordinatorDelegate?
    let service: GoogleSignInService
    
    init(navigationController: UINavigationController, service: GoogleSignInService) {
        self.navigationController = navigationController
        self.service = service
    }
    
    func start() {
        let viewModel = LoginViewModel(service: service)
        let viewController = LoginViewController.instantiate()
        viewController.delegate = self
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func loginSuccess() {
        delegate?.didLogin()
    }
}
