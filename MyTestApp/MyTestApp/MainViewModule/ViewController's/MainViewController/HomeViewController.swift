//
//  MainViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 17.05.2021.
//

import UIKit
import GoogleSignIn

protocol HomeViewControllerDelegate: AnyObject {
    func signOut()
    func showDetails(teamModel: TeamDetailViewModel)
}

class HomeViewController: BaseViewController, Storyboarded {
    var mainViewModel: MainViewModelProtocol!
    weak var delegate: HomeViewControllerDelegate?
    
    let mainCellId = "mainCell"
    let mainCellNibName = "MainTableViewCell"
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompletions()
        registerCell()
        setupDelegates()
    }
    
    func setUpView() {
        mainTableView.separatorStyle = .none
    }
    
    func registerCell() {
        self.mainTableView.register(UINib(nibName: mainCellNibName, bundle: nil), forCellReuseIdentifier: mainCellId)
    }
    
    func setupDelegates() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    func setupCompletions() {
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

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let teamModel = mainViewModel.viewModelForDetailsVC(indexPath)
        delegate?.showDetails(teamModel: teamModel)
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.itemsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: mainCellId, for: indexPath) as! MainTableViewCell
        cell.viewModel = mainViewModel.viewModelForCell(indexPath)
        return cell
    }
    
}
