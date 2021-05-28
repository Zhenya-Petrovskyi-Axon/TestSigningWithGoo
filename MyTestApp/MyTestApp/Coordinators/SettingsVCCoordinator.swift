//
//  PinkVCCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 26.05.2021.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func onLogout()
}

class SettingsVCCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    weak var delegate: SettingsCoordinatorDelegate?
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SettingsViewController.instantiate()
        vc.delegate = self
        navigationController.setViewControllers([vc], animated: true)
    }
}

extension SettingsVCCoordinator: SettingsViewControllerLogoutDelegate {
    func logout() {
        delegate?.onLogout()
    }
    
    
}
