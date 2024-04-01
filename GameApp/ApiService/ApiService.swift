//
//  ApiService.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import Foundation
import UIKit

class ApiService {
    
    static let shared: ApiService = ApiService()
    private init() {}
    
    private let BASE_URL = "https://api.rawg.io/api/games"
    private let API_KEY = ""
    
    func loadLatestGames(completion: @escaping (Result<[Game], Error>) -> Void) {
        if let url = URL(string: "\(BASE_URL)?key=\(API_KEY)") {
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                DispatchQueue.main.async {
                    if let err = error {
                        completion(.failure(err))
                    } else {
                        if let data = data {
                            do {
                                let gamesResponse = try JSONDecoder().decode(GamesResponse.self, from: data)
                                completion(.success(gamesResponse.results))
                            } catch {
                                completion(.failure(error))
                            }
                        } else {
                            completion(.success([]))
                        }
                    }
                }
                
            }
            task.resume()
            
        } else {
            completion(.success([]))
        }
        
    }
    
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                let error = NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                let error = NSError(domain: "Image Error", code: 0, userInfo: nil)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
