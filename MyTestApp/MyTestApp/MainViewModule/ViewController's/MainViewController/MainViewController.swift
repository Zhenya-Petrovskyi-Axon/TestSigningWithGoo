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
    
    // MARK: - Side menu
    private var sideMenuViewController: SideMenuVC?
    private var sideMenuRevealWidth: CGFloat = 260
    private var paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    // MARK: - Collapse side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    
    
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
        sideMenuInit()
    }
    
    // MARK: - SideMenu
    func sideMenuInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sideMenuViewController = storyboard.instantiateViewController(identifier: "SideMenuID") as? SideMenuVC else { return }
        sideMenuViewController.defaultHighlightedCell = 0
        sideMenuViewController.delegate = self
        view.insertSubview(sideMenuViewController.view, at: revealSideMenuOnTop ? 2 : 0)
        /// AUTO - Layout
        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if revealSideMenuOnTop {
            sideMenuTrailingConstraint = sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -sideMenuRevealWidth - paddingForRotation)
            sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            sideMenuViewController.view.widthAnchor.constraint(equalToConstant: sideMenuRevealWidth),
            sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        // MARK: - TODO revisit this func
//        showViewController(viewController: UINavigationController.self, storyboardId: "HomeNavID")
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

extension MainViewController: SideMenuVCDelegate {
    func selectedCell(_ row: Int) {
    }
}
