//
//  YellowVCCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 26.05.2021.
//

import UIKit

class UserListVCCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    var networkService: AlamoNetworkManager
    
    init(navigationController: UINavigationController, networkService: AlamoNetworkManager ) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        let vc = UserListVC.instantiate()
        vc.viewModel = UserVCViewModel(networkService: networkService)
        navigationController.setViewControllers([vc], animated: true)
    }
}
