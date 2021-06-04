//
//  ActivityIndicator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 04.06.2021.
//

import UIKit

var activityView: UIActivityIndicatorView?

extension UIViewController {
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        activityView?.color = .black
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
        print("Showing activity indicator")
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    
}
