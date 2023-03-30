//
//  RMEpisodeDetailViewControllerViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//

import Foundation

protocol RMEpisodeDetailViewViewModelDelegate:AnyObject{
    func didFetchEpisodeDetails()
}


final class RMEpisodeDetailViewViewModel {
    public let episodeUrl: URL?
    enum SectionType{
        case information(viewModel:[RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel:[RMCharacterCollectionViewCellViewModel])
    }
    
    public private(set) var sections = [SectionType]();
    
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    

    
    private var dataTuple:(episode: RMEpisode, characters: [RMCharacter])? {
        didSet{
            createCellViewModels()
            delegate?.didFetchEpisodeDetails();
        }
    }
    
    public func getCharacter(at index:Int) -> RMCharacter?{
        guard let dataTuple = dataTuple else{
            return nil
        }
        return dataTuple.characters[index];
    }
    
    init(episodeUrl:URL?){
        self.episodeUrl = episodeUrl
    }
    public func fetchEpisode(){
        guard let url = episodeUrl, let request = RMRequest(url: url) else{
            return
        }
        RMService.shared.execute(request, expecting: RMEpisode.self) {[weak self] result in
            switch result {
            case .success(let success):
                self?.fetchRelatedCharacters(episode: success)
            case .failure(let failure):
                print(failure.localizedDescription);
            }
        }
    }
    private func fetchRelatedCharacters(episode: RMEpisode){
        let characterRequests = episode.characters.compactMap({
            return URL(string: $0);
        }).compactMap({
            return RMRequest(url: $0)
        });
        let group = DispatchGroup();
        var characters = [RMCharacter]();
        characterRequests.forEach({ request in
            group.enter();
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer{
                    group.leave();
                }
                switch result {
                case .success(let success):
                    characters.append(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        });
        group.notify(queue: .main){
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        }
    }
    private func createCellViewModels(){
        guard let data = dataTuple else{
            return
        }
        let episode = data.0,
            characters = data.1;

            sections = [
                .information(viewModel: [
                    .init(title: "Episode name", value: episode.name),
                    .init(title: "Number", value: episode.episode),
                    .init(title: "Air date", value: episode.air_date)
                ]),
                .characters(viewModel: characters.compactMap({ char in
                        .init(characterName: char.name, characterStatus: char.status, characterImageUrl: URL(string: char.image))
                }))
            ]
    }
}
