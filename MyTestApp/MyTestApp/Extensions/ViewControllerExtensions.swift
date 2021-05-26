//
//  ViewControllerExtensions.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 21.05.2021.
//

import UIKit

extension UIViewController {
    /// Show allert to user if error occures
    func showAlert(text: String) {
        let alert  = UIAlertController(title: "Important!", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
