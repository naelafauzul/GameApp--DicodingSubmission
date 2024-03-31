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
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Double

    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        released = try container.decodeIfPresent(String.self, forKey: .released) ?? ""
        tba = try container.decodeIfPresent(Bool.self, forKey: .tba) ?? false
        backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage) ?? ""
        rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        ratingTop = try container.decodeIfPresent(Double.self, forKey: .ratingTop) ?? 0.0
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



