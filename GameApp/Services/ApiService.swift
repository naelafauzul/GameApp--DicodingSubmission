//
//  ApiService.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import RxCocoa

class ApiService {
    
    static let shared: ApiService = ApiService(networkService: AlamofireNetworkService())
    
    private let networkService: NetworkService
    private let BASE_URL = "https://api.rawg.io/api/"
    private let API_KEY = "2611649569b64ffd99cb9864c33744ec"
    
    private init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadLatestGames() -> Observable<[Game]> {
        guard let url = URL(string: "\(BASE_URL)games?key=\(API_KEY)") else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        return Observable.create { observer in
            self.networkService.request(url) { (result: Result<GamesResponse, Error>) in
                switch result {
                case .success(let gamesResponse):
                    observer.onNext(gamesResponse.results)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}

enum NetworkError: Error {
    case invalidURL
}
