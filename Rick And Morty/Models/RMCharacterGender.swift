//
//  RMCharacterGender.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation

enum RMCharacterGender:String,Decodable{
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "Unknown";
}
