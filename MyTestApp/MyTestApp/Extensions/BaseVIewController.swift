//
//  BaseVIewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 26.05.2021.
//

import UIKit

class BaseViewController: UIViewController {
    private weak var controller: TabBarController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(title: "Menu", style: .plain, target: controller?.revealViewController, action: #selector(controller?.revealViewController()?.revealSideMenu))
        navigationItem.leftBarButtonItem = button
    }
}
