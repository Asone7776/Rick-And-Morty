//
//  RMGetAllLocationsResponse.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    let info: RMGetAllLocationsResponseInfo
    let results:[RMLocation]
}

struct RMGetAllLocationsResponseInfo: Codable{
    let count: Int
    let pages: Int
    let next: String?
    let prev:String?
}
