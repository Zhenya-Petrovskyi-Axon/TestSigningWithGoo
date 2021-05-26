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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(callMenu))
//        navigationItem.leftBarButtonItem = menu
    }
    
    @objc func callMenu() {
        let menuVC = SideMenuVC()
        navigationController?.pushViewController(menuVC, animated: true)
    }
}
