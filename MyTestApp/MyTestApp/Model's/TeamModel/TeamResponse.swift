//
//  TeamEndpoint.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 21.05.2021.
//

import Foundation

struct TeamResponse: Codable {
    var results = [Team]()
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
}
