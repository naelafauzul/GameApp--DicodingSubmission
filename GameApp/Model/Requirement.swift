//
//  Requirement.swift
//  GameApp
//
//  Created by Naela Fauzul Muna on 01/04/24.
//

import Foundation

struct Platform: Decodable {
    let platform: Tools?
    let requirements_en: Requirement?
}

struct Requirement: Decodable {
    let minimum: String

}

struct Tools: Decodable {
    let id: Int
    let name: String

}

