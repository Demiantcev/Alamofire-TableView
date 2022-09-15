//
//  ModelNetwork.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 23.08.2022.
//

import Foundation


struct Model {
    var name: String
    var species: String
    var gender: String
    var location: String
    
    init?(modelData: Result) {
        name = modelData.name
        species = modelData.species.rawValue
        gender = modelData.gender.rawValue
        location = modelData.location.name
    }
}
