//
//  MainVCCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 20.05.2021.
//

import UIKit

protocol MainFlowCoordinatorDelegate: AnyObject {
    func didLogout()
}

class MainFlowCoordinator: CoordinatorProtocol {
    let service: GoogleSignInService
    weak var delegate: MainFlowCoordinatorDelegate?
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, service: GoogleSignInService) {
        self.navigationController = navigationController
        self.service = service
    }
    
    func start() {
        let vc = MainViewController.instantiate()
        let viewModel = MainViewModel(service: service)
        vc.viewModel = viewModel
        vc.delegate = self
        navigationController.setViewControllers([vc], animated: true)
    }
}

extension MainFlowCoordinator: MainViewControllerDelegate {
    func signOut() {
        delegate?.didLogout()
    }
}


