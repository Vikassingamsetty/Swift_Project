//
//  UserDefaults+Extensions.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 22/02/22.
//

import Foundation

extension UserDefaults {
    
    private enum userDefaultsKeys: String {
        case hasOnboarded
        case isLoggedIn
    }
    
    var hasOnboarded: Bool {
        get{
            bool(forKey: userDefaultsKeys.hasOnboarded.rawValue)
        }
        set{
            setValue(newValue, forKey: userDefaultsKeys.hasOnboarded.rawValue)
        }
    }
    
    var isLoggedIn: String {
        get{
            string(forKey: userDefaultsKeys.isLoggedIn.rawValue) ?? "No default value"
        }
        set{
            setValue(newValue, forKey: userDefaultsKeys.isLoggedIn.rawValue)
        }
    }
    
}
