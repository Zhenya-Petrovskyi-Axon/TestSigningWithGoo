////
////  SideMenuModel.swift
////  MyTestApp
////
////  Created by Evhen Petrovskyi on 25.05.2021.
////
//
//import UIKit
//
//protocol CellViewModelProtocol {
//    func viewModelForCell(_ indexPath: IndexPath) -> MenuCellViewModel
//    var itemsCount: Int { get set }
//    var 
//}
//
//class SideMenuViewModel {
//    private(set) var menuItems: [MenuCellModel] = [
//        MenuCellModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
//        MenuCellModel(icon: UIImage(systemName: "music.note")!, title: "Music"),
//        MenuCellModel(icon: UIImage(systemName: "film.fill")!, title: "Movies"),
//        MenuCellModel(icon: UIImage(systemName: "person.fill")!, title: "Profile"),
//        MenuCellModel(icon: UIImage(systemName: "slider.horizontal.3")!, title: "Settings")
//    ] {
//        didSet {
//            self.didHaveData()
//        }
//    
//        private(set) var teams: [Team] = [] {
//            didSet {
//                self.didLoadData()
//            }
//        }
//        
//    var itemsCount: Int {
//        menuItems.count
//        
//    }
//    
//    func viewModelForCell(_ indexPath: IndexPath) -> MenuCellViewModel {
//        let item = menuItems[indexPath.row]
//        return MenuCellViewModel(menuModel: MenuCellModel(icon: item.icon, title: item.title))
//    }
//}
//
