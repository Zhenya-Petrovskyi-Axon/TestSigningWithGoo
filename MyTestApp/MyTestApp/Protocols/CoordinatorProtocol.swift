//
//  Coordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

protocol CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
