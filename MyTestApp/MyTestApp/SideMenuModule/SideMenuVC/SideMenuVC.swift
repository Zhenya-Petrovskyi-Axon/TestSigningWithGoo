//
//  SideMenuVC.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 25.05.2021.
//

import UIKit

protocol SideMenuVCDelegate: AnyObject {
    func selectedCell(_ row: Int)
}

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    let cellId = "sideMenuCell"
    let cellName = "SideMenuCell"
    
    var defaultHighlightedCell: Int = 0
    weak var delegate: SideMenuVCDelegate?
    let cellViewModel = CellViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupDelegates()
        setupView()
        setHighlightedCell()
        updateDataSource()
    }
    
    func registerCell() {
        sideMenuTableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func setupDelegates() {
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
    }
    
    func updateDataSource() {
        DispatchQueue.main.async {
            self.sideMenuTableView.reloadData()
        }
    }
    
    func setupView() {
        sideMenuTableView.backgroundColor = .systemTeal
        sideMenuTableView.separatorStyle = .none
    }
    
    /// Set Highlighted Cell
    func setHighlightedCell() {
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
    }
}

extension SideMenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.selectedCell(indexPath.row)
    }
    
}

extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellViewModel.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SideMenuCell else { fatalError("Cell's xib file doesn't exist") }
        cell.viewModel = cellViewModel.viewModelForCell(indexPath)
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = .systemBlue
        
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }
    
    
}
