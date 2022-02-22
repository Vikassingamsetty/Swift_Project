//
//  String+Extension.swift
//  Magic Meal
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}
