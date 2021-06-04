//
//  ActivityIndicator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 04.06.2021.
//

import UIKit
import ANActivityIndicator

var indicatorView: ANActivityIndicatorView!

extension UIViewController {
    func showActivityIndicator() {
        indicatorView = ANActivityIndicatorView(
            frame: CGRect.init(x: 0, y: 0, width: 75, height: 75),
            animationType: .ballSpinFadeLoader,
            color: .orange,
            padding: .none)
        indicatorView?.center = self.view.center
        indicatorView?.startAnimating()
        self.view.addSubview(indicatorView)
    }
    func hideActivityIndicator() {
        if indicatorView != nil {
            indicatorView?.stopAnimating()
        }
    }
}
