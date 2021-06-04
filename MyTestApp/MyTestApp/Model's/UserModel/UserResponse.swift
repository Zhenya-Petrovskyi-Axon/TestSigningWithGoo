//
//  UserEndPoint.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 02.06.2021.
//

import Foundation

struct DataBox<T: Codable>: Codable {
    let results: [T]
    let info: Info
}
