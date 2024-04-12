//
//  GamesResponse.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//

import Foundation

struct GamesResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Game]
    
}
