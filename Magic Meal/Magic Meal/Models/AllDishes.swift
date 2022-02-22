//
//  AllDishes.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 11/02/22.
//

import Foundation

struct AllDishes: Decodable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let special: [Dish]?
}
