//
//  MainViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

protocol MainViewControllerDelegate: AnyObject {
    func signOut()
    func showDetails(teamModel: TeamDetailViewModel)
}

class MainViewController: UIViewController, Storyboarded {
    
    var mainViewModel: MainViewModelProtocol!
    weak var delegate: MainViewControllerDelegate?
    
    let mainCellId = "mainCell"
    let mainCellNibName = "MainTableViewCell"
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompletions()
        registerCell()
        setupDelegates()
    }
    
    func registerCell() {
        self.mainTableView.register(UINib(nibName: mainCellNibName, bundle: nil), forCellReuseIdentifier: mainCellId)
    }
    
    func setupDelegates() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    func setupCompletions() {
        //        mainViewModel.cellSelected = {
        //            //            self.delegate?.showDetails()
        //        }
        mainViewModel.onLogout = {
            self.delegate?.signOut()
        }
        mainViewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(text: error.description)
            }
        }
        mainViewModel.didLoadData = { [weak self] in
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
    }
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        mainViewModel.logout()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let teamModel = mainViewModel.viewModelForDetailsVC(indexPath)
        delegate?.showDetails(teamModel: teamModel)
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == mainViewModel.itemsCount - 1 {
//            print("Bottom reached - user need's more data")
//            mainViewModel.getData()
//        }
//    }
}

extension MainViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.itemsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: mainCellId, for: indexPath) as! MainTableViewCell
        cell.viewModel = mainViewModel.viewModelForCell(indexPath)
        return cell
    }
    
}
