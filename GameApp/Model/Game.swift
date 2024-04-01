//
//  Game.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 30/03/24.
//
//

import Foundation

struct Game: Decodable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let platforms: [Platform]
    let playtime: Int
    let metacritic: Int
    let suggestionsCount: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case platforms
        case playtime
        case metacritic
        case suggestionsCount = "suggestions_count"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        released = try container.decodeIfPresent(String.self, forKey: .released) ?? ""
        backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage) ?? ""
        rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        platforms = try container.decodeIfPresent([Platform].self, forKey: .platforms) ?? []
        playtime = try container.decodeIfPresent(Int.self, forKey: .playtime) ?? 0
        metacritic = try container.decodeIfPresent(Int.self, forKey: .metacritic) ?? 0
        suggestionsCount = try container.decodeIfPresent(Int.self, forKey: .suggestionsCount) ?? 0
    }
    
    func formattedReleasedDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = inputFormatter.date(from: released) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
}



