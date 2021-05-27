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
        setupButton()
    }
    
    func setupNavigationColor() {
        navigationController?.navigationBar.barTintColor = self.view.backgroundColor
    }
    
    func setupButton() {
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
