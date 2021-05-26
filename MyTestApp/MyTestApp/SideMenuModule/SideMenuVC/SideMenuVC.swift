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
    
    var menuItems: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "house.fill"), title: "Home"),
        SideMenuModel(icon: UIImage(systemName: "music.note"), title: "Music"),
        SideMenuModel(icon: UIImage(systemName: "film.fill"), title: "Movies"),
        SideMenuModel(icon: UIImage(systemName: "person.fill"), title: "Profile"),
        SideMenuModel(icon: UIImage(systemName: "slider.horizontal.3"), title: "Settings")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupDelegates()
        setupView()
        setHighlightedCell()
        
    }
    
    func registerCell() {
        //        sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)
        sideMenuTableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellId)
    }
    func setupDelegates() {
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        updateDataSource()
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
        delegate?.selectedCell(indexPath.row)
    }
    
}

extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sideMenuTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SideMenuCell else { fatalError("Cell's xib file doesn't exist") }
        cell.cellImageView.image = menuItems[indexPath.row].icon
        cell.cellLabel.text = menuItems[indexPath.row].title
        return cell
    }
    
    
}
