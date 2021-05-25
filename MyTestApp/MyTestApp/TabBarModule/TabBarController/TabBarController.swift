//
//  TabBarViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class TabBarController: UITabBarController, TabBarHiddenProtocol {

    // MARK: - Side menu
    private var sideMenuViewController: SideMenuVC?
    private var sideMenuRevealWidth: CGFloat = 260
    private var paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    // MARK: - Collapse side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuInit()
//        hideTabBarMenu()
    }
    
    // MARK: - Hide Tabbar
//    func hideTabBarMenu() {
//        tabBarController?.tabBar.isHidden = true
//        tabBarController?.tabBar.frame = .zero
//    }
    // MARK: - SideMenu
    func sideMenuInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sideMenuViewController = storyboard.instantiateViewController(identifier: "SideMenuID") as? SideMenuVC else { return }
        sideMenuViewController.defaultHighlightedCell = 0
        sideMenuViewController.delegate = self
        view.insertSubview(sideMenuViewController.view, at: revealSideMenuOnTop ? 2 : 0)
        /// AUTO - Layout
        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if revealSideMenuOnTop {
            sideMenuTrailingConstraint = sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -sideMenuRevealWidth - paddingForRotation)
            sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            sideMenuViewController.view.widthAnchor.constraint(equalToConstant: sideMenuRevealWidth),
            sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        // MARK: - TODO revisit this func
//        showViewController(viewController: UINavigationController.self, storyboardId: "HomeNavID")
    }
}

extension TabBarController: SideMenuVCDelegate {
    func selectedCell(_ row: Int) {
    }
}
