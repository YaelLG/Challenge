//
//  ServicesDefinitions.swift
//
//
//  Created by Diego Luna on 13/01/22.
//  Copyright © 2022. All rights reserved.
//

import Foundation

class ServiceDefinitions: NSObject {
    
    // MARK: - Meal
    
    static func urlDessertList(mealType: String) -> String {
        return String(format: "%@filter.php?c=\(mealType)", getBaseURL())
    }
    
    static func urlGetMealDetail(identifier: String) -> String {
        return String(format: "%@lookup.php?i=\(identifier)", getBaseURL())
    }
    
    // MARK: - Base URL
    
    private static func getBaseURL() -> String {
        return "https://themealdb.com/api/json/v1/1/"
    }
}
