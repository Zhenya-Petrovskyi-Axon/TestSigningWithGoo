//
//  MainViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

protocol MainViewControllerDelegate: AnyObject {
    func signOut()
}

class MainViewController: UIViewController, Storyboarded {
    
    var viewModel: MainViewModelProtocol!
    weak var coordinator: AppCoordinator?
    weak var delegate: MainViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "You're in the app, Congratulations"
        setupCompletions()
    }
    
    func setupCompletions() {
        viewModel.onLogout = {
            self.delegate?.signOut()
        }
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(text: error.description)
            }
        }
        viewModel.didLoadData = { [weak self] in
            DispatchQueue.main.async {
                self?.view.backgroundColor = .red
            }
        }
    }
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        viewModel.logout()
    }
}
