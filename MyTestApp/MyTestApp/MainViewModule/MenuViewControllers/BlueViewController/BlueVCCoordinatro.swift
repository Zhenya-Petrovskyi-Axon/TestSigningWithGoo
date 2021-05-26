//
//  BlueVCCoordinatro.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 26.05.2021.
//

import UIKit

class BlueVCCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BlueViewController.instantiate()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    
}
