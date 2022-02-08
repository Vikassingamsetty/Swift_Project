//
//  Route.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import Foundation

enum Route {
    
    static let baseURL = "https://yummie.glitch.me/"
    
    case temp
    
    var description: String {
        switch self {
        case .temp:
            return "dish-categories"
        }
    }
    
}

