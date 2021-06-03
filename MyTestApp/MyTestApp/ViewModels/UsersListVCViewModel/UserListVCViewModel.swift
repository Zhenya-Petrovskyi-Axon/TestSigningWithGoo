//
//  UserListVCViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 02.06.2021.
//

import Foundation

protocol UserListVCViewModelProtocol {
    var currentPage: Int { get set }
    var itemsCount: Int { get }
    var didLoadData: () -> Void { get set }
    var onError: (String) -> Void { get set }
    func getData()
}

class UserVCViewModel: UserListVCViewModelProtocol {
    
    var didLoadData = { }
    var onError: (String) -> Void = { _ in }
    
    var service: AlamoNetworkManager!
    
    private(set) var usersArray: [User] = [] {
        didSet {
            self.didLoadData()
        }
    }
    
    var itemsCount: Int { usersArray.count }
    
    init(networkService: AlamoNetworkManager) {
        service = networkService
        getData()
    }
    
    private let baseUrl = "https://randomuser.me/api/?seed=abc&results="
    private let resultsForPage = "&page="
    
    private var resultsPerPage = 20
    
    private var maxUsersCount = 5000
    internal var currentPage = 1
    
    func getData() {
        let fullUrl = "\(baseUrl)\(resultsPerPage)\(resultsForPage)\(currentPage)"
        service?.getData(type: DataBox<User>.self, url: fullUrl, completion: { [weak self] data in
            switch data {
            case .success(let users):
                self?.usersArray.append(contentsOf: users.results)
                print(self?.usersArray.first?.gender as Any)
                self?.currentPage += 1
            case .failure(let error):
                self?.onError("\(error.localizedDescription)")
            }
        })
    }
    
    
}
