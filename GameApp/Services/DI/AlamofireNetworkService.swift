//
//  AlamofireNetworkService.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation
import Alamofire

class AlamofireNetworkService: NetworkService {
    func request<T>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
