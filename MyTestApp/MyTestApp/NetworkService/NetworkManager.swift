//
//  NetworkService.swift
//  MyTestApp
//
//  Created by Evhen Petrovskyi on 21.05.2021.
//

import Foundation

enum NetworkError: Error {
    case urlIsNotValid
    case urlSessionFailed
    case responseIsNotValid
    case failedToRecieveData
    case unableToDecode(String)
    case systemError(Int)
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkServiceProtocol {
    func getTeamData(page: Int, method: Method, completion: @escaping (Result<[Team], NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let url = "https://free-nba.p.rapidapi.com/teams?page="
    private let headers = [
        "x-rapidapi-key": "a68a73353cmshfa63a8fb22c7ce8p1dd901jsnb03b204ed120",
        "x-rapidapi-host": "free-nba.p.rapidapi.com"
    ]
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func getTeamData(page: Int, method: Method, completion: @escaping (Result<[Team], NetworkError>) -> Void) {
        guard let url = URL(string: "\(url)\(page)") else {
            completion(.failure(.urlIsNotValid))
            return
        }
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        session.dataTask(with: request) { catchedData, response, error in
            if error != nil {
                completion(.failure(.urlSessionFailed))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.responseIsNotValid))
                return
            }
            guard let catchedData = catchedData else {
                completion(.failure(.failedToRecieveData))
                return
            }
            switch response.statusCode {
            case 200...202:
                do {
                    let teamData = try self.decoder.decode(TeamEndpoint.self, from: catchedData)
                    completion(.success(teamData.data))
                } catch let error {
                    completion(.failure(.unableToDecode("\(error)")))
                }
            default:
                completion(.failure(.systemError(response.statusCode)))
            }
        }.resume()
    }
}
