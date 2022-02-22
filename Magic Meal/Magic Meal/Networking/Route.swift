//
//  Route.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import Foundation

enum Route {
    
    static let baseURL = "https://yummie.glitch.me/"
    
    case fetchAllCategories
    case placeOrder(String)
    
    var description: String {
        switch self {
        case .fetchAllCategories:
            return "dish-categories"
        case .placeOrder(let dishID):
            return "order\(dishID)"
        }
    }
    
}

