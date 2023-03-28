//
//  RMEpisodeDetailViewControllerViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    public let episodeUrl:URL?
    
    init(episodeUrl:URL?){
        self.episodeUrl = episodeUrl
    }
    public func fetchEpisode(){
        guard let url = episodeUrl, let request = RMRequest(url: url) else{
            return
        }
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success));
            case .failure(let failure):
                print(failure.localizedDescription);
            }
        }
    }
}
