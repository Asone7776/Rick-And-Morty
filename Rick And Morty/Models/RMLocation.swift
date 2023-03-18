//
//  RMLocation.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation

struct RMLocation: Decodable{
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
