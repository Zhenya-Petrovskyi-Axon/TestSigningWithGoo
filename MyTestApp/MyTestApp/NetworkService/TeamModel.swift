//
//  TeamModel.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 21.05.2021.
//

import Foundation

// MARK: - Team
struct Team: Codable {
    let id: Int
    let abbreviation, city, conference, division: String
    let fullName, name: String

    enum CodingKeys: String, CodingKey {
        case id, abbreviation, city, conference, division
        case fullName = "full_name"
        case name
    }
}
