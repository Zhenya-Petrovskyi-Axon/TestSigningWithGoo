//
//  MainViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 18.05.2021.
//

import UIKit
import GoogleSignIn

protocol MainViewModelDlelegate {
    func logout()
}

protocol MainViewModelProtocol {
    func viewModelForCell(_ indexPath: IndexPath) -> TeamCellViewModel
    var itemsCount: Int { get }
    func logout()
    func getData()
    var didLoadData: () -> Void { get set }
    var onLogout: () -> Void { get set }
    var onError: (String) -> Void { get set }
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
    
    var onError: (String) -> Void = { _ in }
    
    var currentPage: Int = 1
    
    func getData() {
        networkService.getTeamData(page: currentPage, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                self?.teams.append(contentsOf: data)
                self?.currentPage += 1
                print("\(String(describing: self?.teams))")
            case .failure(let error):
                self?.onError("\(error)")
            }
        }
    }
    
    func logout() {
        service.logout(completion: onLogout)
    }
    
    func viewModelForCell(_ indexPath: IndexPath) -> TeamCellViewModel {
        let team = teams[indexPath.row]
        return TeamCellViewModel(teamModel: TeamCellModel(fullName: team.fullName, cityName: team.city, devisionName: team.division))
    }
}
