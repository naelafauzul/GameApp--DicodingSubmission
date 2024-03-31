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
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        next = try container.decodeIfPresent(String.self, forKey: .next) ?? ""
        previous = try container.decodeIfPresent(String.self, forKey: .previous) ?? ""
        results = try container.decode([Game].self, forKey: .results)
    }
}
