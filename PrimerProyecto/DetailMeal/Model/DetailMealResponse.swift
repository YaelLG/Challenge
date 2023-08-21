//
//  DetailMealResponse.swift
//  PrimerProyecto
//
//  Created by Diego Luna on 8/19/23.
//

import Foundation

struct DetailMealResponse: Decodable {
    private let meals: [DetailMeal]
    
    var meal: DetailMeal? {
        meals.first
    }
}

struct DetailMeal: Decodable {
    struct Constants {
        static let maximmumIngredients: Int = 20
    }
    
    let name: String
    let instructions: String
    private var ingredients: [String] = []
    
    var ingredientsPresentation: String {
        return ingredients.joined(separator: ", ")
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailMealParsing.self)
        let nameKey: DetailMealParsing = .init(stringValue: DetailMealParsing.NormalKeys.name.rawValue)
        let instructionsKey: DetailMealParsing = .init(stringValue: DetailMealParsing.NormalKeys.instructions.rawValue)
        self.name = try container.decodeIfPresent(String.self,
                                                  forKey: nameKey) ?? ""
        self.instructions = try container.decodeIfPresent(String.self,
                                                          forKey: instructionsKey) ?? ""
        for index in 1...Constants.maximmumIngredients {
            let codingKeyName: DetailMealParsing = .init(stringValue: "strIngredient\(index)")
            let ingredientName = try container.decodeIfPresent(String.self, forKey: codingKeyName) ?? ""
            if !ingredientName.isEmpty {
                self.ingredients.append(ingredientName)
            }
        }
    }
    
    struct DetailMealParsing: CodingKey {
        enum NormalKeys: String {
            case name = "strMeal"
            case instructions = "strInstructions"
        }
        
        var stringValue: String
        var intValue: Int?

        init(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = ""
        }
    }
}
