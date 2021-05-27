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
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectMain), name: NSNotification.Name(rawValue: "didTapedHome0"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectMusic), name: NSNotification.Name(rawValue: "didTapedMusic1"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectMovies), name: NSNotification.Name(rawValue: "didTapedMovies2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectProfile), name: NSNotification.Name(rawValue: "didTapedProfile3"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectSettings), name: NSNotification.Name(rawValue: "didTapedSettings4"), object: nil)
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
    
    @objc func didSelectMain() {
        tabBarController.selectedIndex = 0
    }
    
    @objc func didSelectMusic() {
        tabBarController.selectedIndex = 1
    }
    
    @objc func didSelectMovies() {
        tabBarController.selectedIndex = 2
    }
    
    @objc func didSelectProfile() {
        tabBarController.selectedIndex = 3
    }
    
    @objc func didSelectSettings() {
        tabBarController.selectedIndex = 4
    }
}
