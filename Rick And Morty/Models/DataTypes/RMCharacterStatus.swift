//
//  RMCharacterStatus.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation

enum RMCharacterStatus: String, Codable{
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text:String{
        switch self {
        case .alive,.dead:
            return rawValue;
        case .unknown:
            return "Unknown"
        }
    }
}
