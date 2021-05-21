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
    let networkService: NetworkService
    weak var delegate: MainFlowCoordinatorDelegate?
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, service: GoogleSignInService, networkService: NetworkService) {
        self.navigationController = navigationController
        self.service = service
        self.networkService = networkService
    }
    
    func start() {
        let vc = MainViewController.instantiate()
        let viewModel = MainViewModel(service: service, networkService: networkService)
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


