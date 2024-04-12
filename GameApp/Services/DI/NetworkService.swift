//
//  NetworkService.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 12/04/24.
//

import Foundation
import Alamofire

protocol NetworkService {
    func request<T: Decodable>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void)
}


