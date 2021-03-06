//
//  Order.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import Foundation

struct Order: Decodable {
    let id: String?
    let name: String?
    let dish: Dish?
}
