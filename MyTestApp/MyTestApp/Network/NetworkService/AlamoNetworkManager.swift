//
//  AlamoNetworkManager.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 02.06.2021.
//

import Alamofire

protocol AlamoNetworkManagerProtocol {
    func getData<T: Codable>(type: T.Type, url: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class AlamoNetworkManager: AlamoNetworkManagerProtocol {
    func getData<T: Codable>(type: T.Type, url: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.urlIsNotValid))
            return
        }
        AF.request(url).responseDecodable(of: type) { response in
            guard let data = response.value else {
                completion(.failure(.failedToRecieveData))
                return
            }
            completion(.success(data))
        }
    }
}
