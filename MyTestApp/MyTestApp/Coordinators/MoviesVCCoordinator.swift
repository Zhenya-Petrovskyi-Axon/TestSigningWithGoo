//
//  YellowVCCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 26.05.2021.
//

import UIKit

class MoviesVCCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MoviesViewController.instantiate()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    
}
