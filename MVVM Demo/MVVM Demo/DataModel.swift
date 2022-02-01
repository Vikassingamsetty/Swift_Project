//
//  DataModel.swift
//  MVVM Demo
//
//  Created by Singamsetty Vikas on 06/11/21.
//

import Foundation

public struct DataModel {
    
    var firstName: String?
    var lastName: String?
    
}

public struct ContactModel: Codable {
    let contacts: [Contact]?
}

struct Contact: Codable {
    let name: String
    let email: String
    let gender: String
}
