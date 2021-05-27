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
        let controller = revealViewController()
        let button = UIBarButtonItem(title: "Menu", style: .plain, target: controller, action: #selector(controller?.revealSideMenu))
        navigationItem.leftBarButtonItem = button
    }
}
