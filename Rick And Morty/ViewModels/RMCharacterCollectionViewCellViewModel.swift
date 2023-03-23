//
//  RMCharacterCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 20/03/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable{
    let characterName:String
    let characterStatus:RMCharacterStatus
    let characterImageUrl:URL?

    init(characterName: String, characterStatus:RMCharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }

    
    public var characterStatusText: String {
        "Status: \(characterStatus.text)"
    }
    public func fetchImage(completion:@escaping (Result<Data, Error>) -> Void){
        guard let url = characterImageUrl else{
            completion(.failure(URLError(.badURL)))
            return;
        }
        ImageLoader.shared.downloadImage(url, completion: completion);
    }
}
extension RMCharacterCollectionViewCellViewModel {
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue;
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName);
        hasher.combine(characterStatus);
        hasher.combine(characterImageUrl);
    }
}
