//
//  RMLocationDetailViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import Foundation

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didPrepareData()
}

final class RMLocationDetailViewViewModel{
    private let location: RMLocation
    
    weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    enum SectionType{
        case information(viewModel:[RMEpisodeInfoCollectionViewCellViewModel])
        case residents(viewModel:[RMCharacterCollectionViewCellViewModel])
    }
    public var sections = [SectionType]();
    
    init(location: RMLocation) {
        self.location = location
    }
    
    public func fetchRelatedCharacters(){
        let requests = location.residents.compactMap { stringUrl in
            return URL(string: stringUrl);
        }.compactMap { url in
            return RMRequest(url: url);
        };
        let group = DispatchGroup();
        var characters:[RMCharacter] = [];
        requests.forEach { request in
            group.enter();
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer{
                    group.leave();
                }
                switch result {
                case .success(let character):
                characters.append(character);
                case .failure(let failure):
                    print(failure);
                }
            }
        }
        group.notify(queue: .main){
            self.prepareSections(with: characters)
        }
    }
    private func prepareSections(with characters:[RMCharacter]){
        sections = [
            .information(viewModel: [
                .init(title: "Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
            ]),
            .residents(viewModel: characters.compactMap({ character in
                return .init(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
            }))
        ]
        delegate?.didPrepareData()
    }
}
