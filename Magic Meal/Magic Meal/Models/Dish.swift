//
//  Dish.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import Foundation

struct Dish {
    let id, name, description, image: String?
    let calorie: Double?
    
    var formattedCalories: String {
        return String(format: "%.2f calories", calorie ?? 0)
    }
}
