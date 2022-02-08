//
//  AppError.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 05/02/22.
//

import Foundation

enum AppError: LocalizedError {
    
    case errorDecoding
    case unknownError
    case invalidError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response is not decoded"
        case .unknownError:
            return "No Idea on the unknown error"
        case .invalidError:
            return "Help me with valid URL"
        case .serverError(let error):
            return error
        }
    }
    
}
