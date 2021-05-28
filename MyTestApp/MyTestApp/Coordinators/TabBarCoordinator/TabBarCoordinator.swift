//
//  File.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

/// Delegate protocol to logout from appCoordinator
protocol TabBarCoordinatorDelegate: AnyObject {
    func logout()
}

// MARK: - Main Tab Bar coordintor
class TabBarCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    let service: GoogleSignInService
    let networkService: NetworkService
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    weak var deleagte: TabBarCoordinatorDelegate?
    
    init(navigationController: UINavigationController, service: GoogleSignInService, networkService: NetworkService, tabBarController: UITabBarController) {
        self.service = service
        self.networkService = networkService
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        navigationController.setViewControllers([tabBarController], animated: true)
        setTabs()
        setupNotifications()
    }
    
    // MARK: - Setup tabs
    func setTabs() {
        // Home
        let homeCoordNavVC = UINavigationController()
        let homeVCCoordinator = HomeVCCoordinator(navigationController: homeCoordNavVC, service: service, networkService: networkService)
        childCoordinators.append(homeVCCoordinator)
        homeVCCoordinator.start()
        // Music
        let musicCoordNavVC = UINavigationController()
        let musicVCCoordinator = MusicVCCoordinator(navigationController: musicCoordNavVC)
        childCoordinators.append(musicVCCoordinator)
        musicVCCoordinator.start()
        // Movies
        let moviesCoordNavVC = UINavigationController()
        let moviesVCCoordinator = MoviesVCCoordinator(navigationController: moviesCoordNavVC)
        childCoordinators.append(moviesVCCoordinator)
        moviesVCCoordinator.start()
        // Profile
        let profileNavVC = UINavigationController()
        let profileVCCoordinator = ProfileVCCoordinator(navigationController: profileNavVC)
        childCoordinators.append(profileVCCoordinator)
        profileVCCoordinator.start()
        // Settings
        let settingskNavVC = UINavigationController()
        let settingsVCCoordinator = SettingsVCCoordinator(navigationController: settingskNavVC)
        childCoordinators.append(settingsVCCoordinator)
        settingsVCCoordinator.delegate = self
        settingsVCCoordinator.start()
        // Set Tab Bar Items
        tabBarController.setViewControllers([homeCoordNavVC, musicCoordNavVC, moviesCoordNavVC, profileNavVC, settingskNavVC], animated: false)
        tabBarController.tabBar.isHidden = true
    }
    
    // MARK: - Setup sliding menu switch observers
    func setupNotifications() {
        /// Home vc
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectMain), name: NSNotification.Name(rawValue: "didSelectHome"), object: nil)
        /// Music vc
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectMusic), name: NSNotification.Name(rawValue: "didSelectMusic"), object: nil)
        /// Movies vc
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectMovies), name: NSNotification.Name(rawValue: "didSeclectMovies"), object: nil)
        /// Profile vc
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectProfile), name: NSNotification.Name(rawValue: "didSelectProfile"), object: nil)
        /// Settings vc
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectSettings), name: NSNotification.Name(rawValue: "didSelectSettings"), object: nil)
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

// MARK: - LogoutDelegate
extension TabBarCoordinator: SettingsCoordinatorDelegate {
    func onLogout() {
        deleagte?.logout()
    }
}
