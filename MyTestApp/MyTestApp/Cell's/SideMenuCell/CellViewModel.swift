//
//  MenuCellViewModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 27.05.2021.
//

import UIKit

class CellViewModel {
    var menuItems: [MenuCellModel] = [
        MenuCellModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
        MenuCellModel(icon: UIImage(systemName: "figure.stand.line.dotted.figure.stand")!, title: "Gender"),
        MenuCellModel(icon: UIImage(systemName: "film.fill")!, title: "Users"),
        MenuCellModel(icon: UIImage(systemName: "person.fill")!, title: "Profile"),
        MenuCellModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "Settings")
    ]
    
    func viewModelForCell(_ indexPath: IndexPath) -> MenuCellViewModel {
        let item = menuItems[indexPath.row]
        return MenuCellViewModel(menuModel: MenuCellModel(icon: item.icon, title: item.title))
    }
}
