//
//  DetailsViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 24.05.2021.
//

import UIKit

struct TeamDetailModel {
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    let fullName: String
    let name: String
}

class TeamDetailViewModel {
    let teamModel: TeamDetailModel
    init(teamModel: TeamDetailModel) {
        self.teamModel = teamModel
    }
}



class DetailsViewController: UIViewController {
    
    var detailsViewModel: TeamDetailViewModel! {
        didSet {
            // TODO: Crate DetailsVC description
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
