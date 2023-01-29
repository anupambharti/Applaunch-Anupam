//
//  Launches.swift
//  Applaunch-Anupam
//
//  Created by Anu on 26/01/23.
//

import Foundation

struct Launch: Codable {
    var name: String
    var rocket: String
   // var success: Bool
}

enum CodingKeys: String, CodingKey {
    case
    name = "name",
    rocket = "rocket"
    //success = "success"
}

