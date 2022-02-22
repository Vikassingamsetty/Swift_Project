//
//  APIResponse.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 11/02/22.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
