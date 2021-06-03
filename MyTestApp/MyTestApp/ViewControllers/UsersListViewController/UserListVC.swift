//
//  YellowViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class UserListVC: BaseViewController, Storyboarded {
    @IBOutlet weak var usersCollectionView: UICollectionView!
    let cellID = "usersCollectionViewCell"
    let cellName = "UsersCollectionViewCell"
    var viewModel: UserListVCViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupCollectionView()
        registerCell()
    }
    
    // MARK: - Register cell
    func registerCell() {
        usersCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    // MARK: - Equal Background Color
    func setupCollectionView() {
        usersCollectionView.backgroundColor = view.backgroundColor
    }
    
    // MARK: - Call usersViewModel to bind data
    func setupBindings() {
        self.viewModel.didLoadData = { [weak self] in
            self?.usersCollectionView.reloadData()
        }
        self.viewModel.onError = { error in
            print("\(error)")
        }
    }
    
}

extension UserListVC: UICollectionViewDelegate {
    
}
extension UserListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    
}
