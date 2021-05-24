//
//  MainVCCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 20.05.2021.
//

import UIKit

protocol MainFlowCoordinatorDelegate: AnyObject {
    func didLogout()
} 

class MainFlowCoordinator: CoordinatorProtocol {
    let service: GoogleSignInService
    let networkService: NetworkService
    weak var delegate: MainFlowCoordinatorDelegate?
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, service: GoogleSignInService, networkService: NetworkService) {
        self.navigationController = navigationController
        self.service = service
        self.networkService = networkService
    }
    
    func start() {
        let vc = MainViewController.instantiate()
        let viewModel = MainViewModel(service: service, networkService: networkService)
        vc.mainViewModel = viewModel
        vc.delegate = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func goToDetails(viewModel: TeamDetailViewModel) {
        print(viewModel.teamModel.fullName)
        let vcToPresent = DetailsViewController.instantiate()
//        let vc = DetailsViewController()
        vcToPresent.detailsViewModel = viewModel
        print(viewModel)
        navigationController.pushViewController(vcToPresent, animated: true)
    }
}

extension MainFlowCoordinator: MainViewControllerDelegate {
    func showDetails(viewModel: TeamDetailViewModel) {
        print(viewModel.teamModel.fullName)
        goToDetails(viewModel: viewModel)
    }
    
    func signOut() {
        delegate?.didLogout()
    }
}


