//
//  RMEpisodeCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//

import UIKit

final class RMEpisodeCollectionViewCellViewModel: Hashable, Equatable{
    let name:String
    let air_date:String
    let episode:String
    public let borderColor:UIColor
    

    init(name:String,air_date:String,episode:String,borderColor:UIColor = .systemBlue) {
        self.name = name
        self.air_date = air_date
        self.episode = episode
        self.borderColor = borderColor;
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
