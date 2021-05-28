//
//  BaseVIewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 26.05.2021.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationColor()
        setupMenuButton()
    }
    
    func setupNavigationColor() {
        navigationController?.navigationBar.barTintColor = self.view.backgroundColor
    }
    
    func setupMenuButton() {
        let controller = revealViewController()
        let button = UIBarButtonItem(
            image: UIImage(systemName: "list.bullet"),
            style: .plain,
            target: controller,
            action: #selector(controller?.revealSideMenu))
        navigationItem.leftBarButtonItem = button
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
}

//extension BaseViewController: UIScrollViewDelegate {
//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let pan = scrollView.panGestureRecognizer
//            let velocity = pan.velocity(in: scrollView).y
//            if velocity < -5 {
//                self.navigationController?.setNavigationBarHidden(true, animated: true)
//                self.navigationController?.setToolbarHidden(true, animated: true)
//            } else if velocity > 5 {
//                self.navigationController?.setNavigationBarHidden(false, animated: true)
//                self.navigationController?.setToolbarHidden(false, animated: true)
//            }
//        }
//}
