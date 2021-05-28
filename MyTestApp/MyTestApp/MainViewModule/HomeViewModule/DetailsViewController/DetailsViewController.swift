//
//  DetailsViewController.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 24.05.2021.
//

import UIKit

class DetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var divisionNameLabel: UILabel!
    @IBOutlet weak var conferenceNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    var detailsViewModel: TeamDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    func setupLabels() {
        guard detailsViewModel != nil else { return }
        shortNameLabel?.text = detailsViewModel.teamModel.name
        fullNameLabel?.text = detailsViewModel.teamModel.fullName
        divisionNameLabel?.text = detailsViewModel.teamModel.division
        conferenceNameLabel?.text = detailsViewModel.teamModel.conference
        cityNameLabel?.text = detailsViewModel.teamModel.city
        abbreviationLabel?.text = detailsViewModel.teamModel.abbreviation
    }
}
