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

class DetailsViewController: UIViewController, Storyboarded {
    
    //    @IBOutlet weak var
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var divisionNameLabel: UILabel!
    @IBOutlet weak var conferenceNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    
    var detailsViewModel: TeamDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Crate DetailsVC description
        shortNameLabel?.text = detailsViewModel.teamModel.name
        fullNameLabel?.text = detailsViewModel.teamModel.fullName
        divisionNameLabel?.text = detailsViewModel.teamModel.division
        conferenceNameLabel?.text = detailsViewModel.teamModel.conference
        cityNameLabel?.text = detailsViewModel.teamModel.city
        abbreviationLabel?.text = detailsViewModel.teamModel.abbreviation
    }
}
