//
//  GetCharactersResponse.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 19/03/23.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    let info: RMGetAllCharactersResponseInfo
    let results:[RMCharacter]
}

struct RMGetAllCharactersResponseInfo: Codable{
    let count: Int
    let pages: Int
    let next: String?
    let prev:String?
}
