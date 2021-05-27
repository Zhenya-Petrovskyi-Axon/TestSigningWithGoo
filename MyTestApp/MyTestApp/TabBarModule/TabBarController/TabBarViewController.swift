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
    private var sideMenuRevealWidth: CGFloat = 150
    private var paddingForRotation: CGFloat = 150
    var isExpanded: Bool = false
    // MARK: - Collapse side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    
    private let didSelectHome = "didSelectHome"
    private let didSelectMusic = "didSelectMusic"
    private let didSelectMovies = "didSeclectMovies"
    private let didSelectProfile = "didSelectProfile"
    private let didSelectSettings = "didSelectSettings"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuInit()
    }
    
    // MARK: - SideMenu
    func sideMenuInit() {
        // Shadow Background View
        sideMenuShadowView = GestureRecognizerTappableView(frame: self.view.bounds)
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
            // Home
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: didSelectHome), object: nil)
        case 1:
            // Music
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: didSelectMusic), object: nil)
        case 2:
            // Movies
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: didSelectMovies), object: nil)
        case 3:
            // Profile
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: didSelectProfile), object: nil)
        case 4:
            // Settings
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: didSelectSettings), object: nil)
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
        } else {
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
        guard ((sideMenuViewController?.view) != nil) else { return false }
        if (touch.view?.isDescendant(of: (self.sideMenuViewController?.view)!))! {
            return false
        }
        if (touch.view is GestureRecognizerTappable) {
            return true
        } else {
            return false
        }
    }
}

extension UIViewController {
    // With this extension you can access the MainViewController from the child view controllers.
    func revealViewController() -> TabBarController? {
        tabBarController as? TabBarController
    }
}

