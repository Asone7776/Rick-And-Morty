//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import Foundation

protocol RMEpisodeDataRender {
    var episode:String {get}
    var air_date:String {get}
    var name:String {get}
}

final class RMCharacterEpisodeCollectionViewCellViewModel{
    let episodeDataUrl: URL?
    private var dataBlock: ((RMEpisodeDataRender)->Void)?
    private var isFetching = false;
    private var episode: RMEpisode?{
        didSet {
            guard let model = episode else{
                return
            }
            dataBlock?(model);
        }
    }
    //MARK: Init
    
    init(episodeDataUrl:URL?){
        self.episodeDataUrl = episodeDataUrl;
    }
    //MARK: Publisher and subscriber pattern
    
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void){
        self.dataBlock = block;
    }
    
    public func fetchEpisode() {
        guard !isFetching else{
            if let model = episode{
                self.dataBlock?(model);
            }
            return
        }
        guard let url = self.episodeDataUrl,let request = RMRequest(url: url) else{
            return
        }
        isFetching = true;
        RMService.shared.execute(request, expecting: RMEpisode.self){ [weak self] result in
            switch result {
            case .success(let episode):
                DispatchQueue.main.async {
                    self?.episode = episode
                }
            case .failure(let error):
                print(String(describing: error));
            }
        }
    }
}
