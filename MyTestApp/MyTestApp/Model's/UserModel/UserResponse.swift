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

//struct UserResponse: Codable {
//    let result: [User]
//    let info: Info
//}

//// MARK: - Users
//struct Users: Codable {
//    let results: [User]
//    let info: Info
//}

