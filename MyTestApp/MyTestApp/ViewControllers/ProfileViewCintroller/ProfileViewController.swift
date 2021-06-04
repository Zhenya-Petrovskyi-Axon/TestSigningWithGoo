//
//  BlackViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class ProfileViewController: BaseViewController, Storyboarded {
    @IBOutlet weak var userCollectionView: UICollectionView!
    let cellID = "userCollectionViewCell"
    let cellName = "UserCollectionViewCell"
    var viewModel: UserVCViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserCollectionViewColor()
        registerImageCell()
        setupDelegates()
        setupBindings()
    }
    
    func setupUserCollectionViewColor() {
        userCollectionView.backgroundColor = self.view.backgroundColor
    }
    
    func registerImageCell() {
        userCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    func setupBindings() {
        viewModel.didLoadData = {
            DispatchQueue.main.async {
                self.userCollectionView.reloadData()
            }
        }
    }
    
    func setupDelegates() {
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserCollectionViewCell
        cell.viewModel = viewModel.viewModelForImageCell(indexPath)
        cell.layer.cornerRadius = cell.frame.size.height / 2
        return cell
    }
    
    
}
