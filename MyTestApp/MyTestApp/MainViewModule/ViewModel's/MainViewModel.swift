//
//  MainViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

protocol MainViewModelProtocol {
    var currentPage: Int { get set }
    var itemsCount: Int { get }
    var didLoadData: () -> Void { get set }
    var onLogout: () -> Void { get set }
    var onError: (String) -> Void { get set }
    var cellSelected: () -> Void { get set }
    func logout()
    func getData()
    func viewModelForCell(_ indexPath: IndexPath) -> TeamCellViewModel
    func viewModelForDetailsVC(_ indexPath: IndexPath) -> TeamDetailViewModel
}

class MainViewModel: MainViewModelProtocol {
    private(set) var teams: [Team] = [] {
        didSet {
            self.didLoadData()
        }
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
    var isPaginating: Bool = false
    var itemsCount: Int { teams.count }
    
    func getData() {
        networkService.getTeamData(page: currentPage, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                self?.teams.append(contentsOf: data)
                self?.currentPage += 1
                print(self!.currentPage)
            case .failure(let error):
                self?.onError("\(error)")
            }
        }
    }
    
    func logout() {
        service.logout(completion: onLogout)
    }
    
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
