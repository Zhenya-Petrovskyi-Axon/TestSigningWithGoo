//
//  File.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit



class TabBarCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    let service: GoogleSignInService
    let networkService: NetworkService
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController, service: GoogleSignInService, networkService: NetworkService) {
        self.service = service
        self.networkService = networkService
        self.navigationController = navigationController
        tabBarController = UITabBarController()
        
    }
    
    func start() {
        navigationController.setViewControllers([tabBarController], animated: true)
        setTabs()
    }
    
    func setTabs() {
        let mainCoordNavVC = UINavigationController()
        let mainCoordinator = MainFlowCoordinator(navigationController: mainCoordNavVC, service: service, networkService: networkService)
        tabBarController.setViewControllers([mainCoordNavVC], animated: false)
        mainCoordinator.start()
    }
    
    
}

