//
//  YellowViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class UserListVC: BaseViewController, Storyboarded {
    @IBOutlet weak var usersCollectionView: UICollectionView!
    let cellID = "userCell"
    let cellName = "UserCell"
    var viewModel: UserListVCViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setUpDelegates()
        setupCollectionView()
        registerCell()
    }
    
    // MARK: - Setup coleection view delegates
    func setUpDelegates() {
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
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
            DispatchQueue.main.async {
                self?.usersCollectionView.reloadData()
            }
        }
        self.viewModel.onError = { error in
            self.showAlert(text: error)
        }
        self.viewModel.onLoadData = {
            self.showActivityIndicator()
        }
        self.viewModel.loadDataSuccess = {
            self.hideActivityIndicator()
        }
    }
}

extension UserListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.itemsCount - 1 {
            guard !viewModel.isPaginating else { return }
            viewModel.dataEnded()
        }
    }
}

extension UserListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserCell
        cell.viewModel = viewModel.viewModelForCell(indexPath)
        return cell
    }
}
