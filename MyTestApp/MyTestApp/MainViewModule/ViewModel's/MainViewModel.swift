//
//  MainViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

//protocol MainViewModelDelegate: AnyObject {
//    func showDetails(user: TeamDetailViewModel)
//}

protocol MainViewModelProtocol {
    var itemsCount: Int { get }
    var didLoadData: () -> Void { get set }
    var onLogout: () -> Void { get set }
    var onError: (String) -> Void { get set }
    var cellSelected: () -> Void { get set }
    func logout()
    func getData()
    func viewModelForCell(_ indexPath: IndexPath) -> TeamCellViewModel
    func viewModelForDetailsVC(_ indexPath: IndexPath) -> TeamDetailViewModel
//    func didSelectCell(_ indexPath: IndexPath)
    
    
}

class MainViewModel: MainViewModelProtocol {
    
    private(set) var teams: [Team] = [] {
        didSet {
            self.didLoadData()
        }
    }
    
    var itemsCount: Int {
        return teams.count
    }
    
    let service: GoogleSignInService
    let networkService: NetworkService
    init(service: GoogleSignInService, networkService: NetworkService) {
        self.service = service
        self.networkService = networkService
        getData()
    }
    
    var onLogout = { }
    
    var didLoadData = { }
    
    var cellSelected: () -> Void = {  }
    
    var onError: (String) -> Void = { _ in }
    
    var currentPage: Int = 1
    
    func getData() {
        networkService.getTeamData(page: currentPage, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                self?.teams.append(contentsOf: data)
                self?.currentPage += 1
            case .failure(let error):
                self?.onError("\(error)")
            }
        }
    }
    
    func logout() {
        service.logout(completion: onLogout)
    }
    
//    func didSelectCell(_ indexPath: IndexPath) {
//        let viewModel = viewModelForDetailsVC(indexPath)
//        self.delegate?.showDetails(user: viewModel)
////        // Create view model for details
////        let teamViewModel = viewModelForDetailsVC(indexPath)
////        coordinator?.goToDetails(viewModel: teamViewModel)
//        //        let viewModelForDetails = viewModelForCell(indexPath)
//        //        View model to coordinator
//        //        Coordinator crate DetailsVC
//        //        Присвоить View model coordinator to Details viewModel
//        //        print(vc.detailsViewModel.teamModel.fullName)
//
//
//    }
    
    func viewModelForDetailsVC(_ indexPath: IndexPath) -> TeamDetailViewModel {
        let item = teams[indexPath.row]
        return TeamDetailViewModel(teamModel: TeamDetailModel(
                                                abbreviation: item.abbreviation,
                                                city: item.city,
                                                conference: item.conference,
                                                division: item.division,
                                                fullName: item.fullName,
                                                name: item.name))
    }
    
    func viewModelForCell(_ indexPath: IndexPath) -> TeamCellViewModel {
        let team = teams[indexPath.row]
        return TeamCellViewModel(teamModel: TeamCellModel(fullName: team.fullName,
                                                          cityName: team.city,
                                                          devisionName: team.division))
    }
}
