//
//  Country.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 6/8/23.
//

import Foundation

struct MealsResponse: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let name: String
    let imageURL: String
    let identifier: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case imageURL = "strMealThumb"
        case identifier = "idMeal"
    }
}
