//
//  RMCharacter.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation

struct RMCharacter: Decodable{
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url:String
    let created: String
}
