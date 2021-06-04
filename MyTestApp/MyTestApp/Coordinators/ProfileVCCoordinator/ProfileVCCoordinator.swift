//
//  BlackVCCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 26.05.2021.
//

import UIKit

class ProfileVCCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    var networkService: AlamoNetworkManager
    
    init(navigationController: UINavigationController, networkService: AlamoNetworkManager) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        let vc = ProfileViewController.instantiate()
        vc.viewModel = UserVCViewModel(networkService: networkService)
        navigationController.setViewControllers([vc], animated: true)
    }
}
