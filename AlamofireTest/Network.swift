//
//  Network.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 05.08.2022.
//

import Foundation
// MARK: - Result

struct Welcome {
    var results: [Characters]
}

struct Characters {
    
    let name: String
    let species: String
    let gender: String
    let status: String
    let image: String

}

// MARK: - Locations

struct Locations {
    
    let name: String
    let type: String
    let dimension: String
}
// MARK: - Episode

struct Episode {
    let airDate: String
    let name: String
    let episode: String
    
    enum CodingKeys: String, CodingKey {
        
        case airDate = "air_date"
        case name
        case episode
    }
}
