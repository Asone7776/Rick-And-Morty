//
//  RMGetAllEpisodesResponse.swift
//  Rick And Morty
//
//  Created by Uzkassa on 30/03/23.
//

import Foundation


struct RMGetAllEpisodesResponse: Codable {
    let info: RMGetAllEpisodessResponseInfo
    let results:[RMEpisode]
}

struct RMGetAllEpisodessResponseInfo: Codable{
    let count: Int
    let pages: Int
    let next: String?
    let prev:String?
}
