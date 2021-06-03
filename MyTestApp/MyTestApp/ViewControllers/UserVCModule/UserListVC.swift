//
//  YellowViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class UserListVC: BaseViewController, Storyboarded {
    
    var viewModel: UserListVCViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Call usersViewModel to bind data
    func setupBindings() {
        self.viewModel.didLoadData = { [weak self] in
            print("\(self?.viewModel.itemsCount)")
        }
        self.viewModel.onError = { error in
            print("\(error)")
        }
    }
    
}
