//
//  MainVCCoordinator.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 20.05.2021.
//

import UIKit

protocol HomeVCCoordinatorDelegate: AnyObject {
    func didLogout()
} 

class HomeVCCoordinator: CoordinatorProtocol {
    let service: GoogleSignInService
    let networkService: NetworkService
    weak var delegate: HomeVCCoordinatorDelegate?
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, service: GoogleSignInService, networkService: NetworkService) {
        self.navigationController = navigationController
        self.service = service
        self.networkService = networkService
    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        let viewModel = HomeViewModel(service: service, networkService: networkService)
        vc.mainViewModel = viewModel
        vc.delegate = self
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func goToDetails(viewModel: TeamDetailViewModel) {
        print(viewModel.teamModel.fullName)
        let vcToPresent = DetailsViewController.instantiate()
        vcToPresent.detailsViewModel = viewModel
        print(viewModel)
        navigationController.pushViewController(vcToPresent, animated: true)
    }
}

extension HomeVCCoordinator: HomeViewControllerDelegate {
    func showDetails(teamModel: TeamDetailViewModel) {
        print(teamModel.teamModel.fullName)
        goToDetails(viewModel: teamModel)
    }
    
    func signOut() {
        delegate?.didLogout()
    }
}


