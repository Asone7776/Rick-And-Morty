//
//  RMCharacterStatus.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation

enum RMCharacterStatus: String, Decodable{
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "Unknown"
}
