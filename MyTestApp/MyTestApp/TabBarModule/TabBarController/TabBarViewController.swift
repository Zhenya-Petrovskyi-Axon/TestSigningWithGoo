//
//  TabBarViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Side menu
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 180
    private var paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    // MARK: - Collapse side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuInit()
    }
    
    // MARK: - SideMenu
    func sideMenuInit() {
        // Shadow Background View
        sideMenuShadowView = UIView(frame: self.view.bounds)
        sideMenuShadowView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sideMenuShadowView?.backgroundColor = .black
        sideMenuShadowView?.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView!, at: 1)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sideMenuViewController = storyboard.instantiateViewController(identifier: "SideMenuID") as? SideMenuVC
        self.sideMenuViewController.defaultHighlightedCell = 0
        self.sideMenuViewController.delegate = self
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
    }
}

extension TabBarController: SideMenuVCDelegate {
    func selectedCell(_ row: Int) {
        switch row {
        case 0:
            print("0")
        // Home
        //            self.showViewController(viewController: UINavigationController.self, storyboardId: "BlueViewController")
        case 1:
            print("1")
        // Music
        //            self.showViewController(viewController: UINavigationController.self, storyboardId: "GreenViewController")
        case 2:
            print("2")
        // Movies
        //            self.showViewController(viewController: UINavigationController.self, storyboardId: "YellowViewController")
        case 3:
            print("3")
        // Books
        //            self.showViewController(viewController: UINavigationController.self, storyboardId: "BlackViewController")
        case 4:
            print("4")
        //            self.showViewController(viewController: UINavigationController.self, storyboardId: "PinkViewController")
        default:
            break
        }
        DispatchQueue.main.async { self.sideMenuState(expanded: false) }
    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView?.alpha = 0.6 }
        }
        else {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView?.alpha = 0.0 }
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    // Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
    @objc func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
}

extension TabBarController: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard ((sideMenuViewController?.view) != nil) else { return true }
        if (touch.view?.isDescendant(of: (self.sideMenuViewController?.view)!))! {
            return false
        }
        return true
    }
}

extension UIViewController {
    // With this extension you can access the MainViewController from the child view controllers.
    func revealViewController() -> TabBarController? {
        tabBarController as? TabBarController
        //        var viewController: UITabBarController? = self
        //
        //        if viewController != nil && viewController is TabBarController {
        //            return viewController! as? TabBarController
        //        }
        //        while (!(viewController is TabBarController) && viewController?.parent != nil) {
        //            viewController = viewController?.parent as? TabBarController
        //        }
        //        if viewController is TabBarController {
        //            return viewController as? TabBarController
        //        }
        //        return nil
    }
}

