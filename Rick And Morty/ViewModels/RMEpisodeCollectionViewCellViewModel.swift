//
//  RMEpisodeCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//

import Foundation

final class RMEpisodeCollectionViewCellViewModel: Hashable, Equatable{
    let name:String
    let air_date:String
    let episode:String

    init(name:String,air_date:String,episode:String) {
        self.name = name
        self.air_date = air_date
        self.episode = episode
    }
}
extension RMEpisodeCollectionViewCellViewModel {
    
    static func == (lhs: RMEpisodeCollectionViewCellViewModel, rhs: RMEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue;
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name);
        hasher.combine(air_date);
        hasher.combine(episode);
    }
}
