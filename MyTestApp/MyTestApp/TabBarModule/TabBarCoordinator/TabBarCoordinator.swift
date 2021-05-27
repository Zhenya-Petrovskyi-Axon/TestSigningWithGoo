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
    
    init(navigationController: UINavigationController, service: GoogleSignInService, networkService: NetworkService, tabBarController: UITabBarController) {
        self.service = service
        self.networkService = networkService
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        navigationController.setViewControllers([tabBarController], animated: true)
        setTabs()
    }
    
    func setTabs() {
        // Home
        let mainCoordNavVC = UINavigationController()
        let homeVCCoordinator = HomeVCCoordinator(navigationController: mainCoordNavVC, service: service, networkService: networkService)
        childCoordinators.append(homeVCCoordinator)
        homeVCCoordinator.start()
        // Green
        let greenCoordNavVC = UINavigationController()
        let greenVCCoordinator = GreenVCCoordinator(navigationController: greenCoordNavVC)
        childCoordinators.append(greenVCCoordinator)
        greenVCCoordinator.start()
        // Yellow
        let yellowCoordNavVC = UINavigationController()
        let yellowVCCoordinator = YellowVCCoordinator(navigationController: yellowCoordNavVC)
        childCoordinators.append(yellowVCCoordinator)
        yellowVCCoordinator.start()
        // Black
        let blackNavVC = UINavigationController()
        let blackVCCoordinator = BlackVCCoordinator(navigationController: blackNavVC)
        childCoordinators.append(blackVCCoordinator)
        blackVCCoordinator.start()
        // Pink
        let pinkNavVC = UINavigationController()
        let pinkVCCoordinator = PinkVCCoordinator(navigationController: pinkNavVC)
        childCoordinators.append(pinkVCCoordinator)
        pinkVCCoordinator.start()
        // Set Tab Bar tabs
        tabBarController.setViewControllers([mainCoordNavVC, greenCoordNavVC, yellowCoordNavVC, blackNavVC, pinkNavVC], animated: false)
        tabBarController.tabBar.isHidden = true
    }
    
    func didSelectProfile() {
        tabBarController.selectedIndex = 1
    }
    
    func didSelectMain() {
        tabBarController.selectedIndex = 0
    }
}
