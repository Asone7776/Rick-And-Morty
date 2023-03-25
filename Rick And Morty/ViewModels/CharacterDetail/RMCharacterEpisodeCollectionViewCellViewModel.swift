//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel{
    let episodeDataUrl: URL?
    init(episodeDataUrl:URL?){
        self.episodeDataUrl = episodeDataUrl;
    }
    
    public func getEpisode(completion: @escaping (Result<RMEpisode, Error>) -> Void) {
        guard let url = self.episodeDataUrl,let request = RMRequest(url: url) else{
            completion(.failure(URLError(.badURL)));
            return;
        }
        RMService.shared.execute(request, expecting: RMEpisode.self,completion: completion);
    }
}
