//
//  BlackViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

class ProfileViewController: BaseViewController, Storyboarded {
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var pickerTextField: UITextField!
    let cellID = "userCollectionViewCell"
    let cellName = "UserCollectionViewCell"
    var itemCellGap: CGFloat = 0
    var itemCellWidth: CGFloat { view.bounds.size.width / 2 }
    var itemCellHeight: CGFloat { itemCellWidth }
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
        userCollectionView.bounds.size.height = itemCellWidth + itemCellGap
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = itemCellWidth
        let itemIndex = (targetContentOffset.pointee.x) / pageWidth
        targetContentOffset.pointee.x = round(itemIndex) * pageWidth
    }
}

// MARK: For paging with freezing on next set
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt sizeForItemAtIndexPath: IndexPath) -> CGSize {
        let itemCellSize = CGSize(width: itemCellWidth, height: itemCellHeight)
        return itemCellSize
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserCollectionViewCell
        cell.viewModel = viewModel.viewModelForImageCell(indexPath)
        cell.backgroundColor = .clear
        return cell
    }
}
