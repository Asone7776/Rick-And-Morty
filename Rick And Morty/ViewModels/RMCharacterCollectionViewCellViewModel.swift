//
//  RMCharacterCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 20/03/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel{
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
        let request = URLRequest(url: url);
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)));
                return;
            }
            completion(.success(data));
        }
        task.resume();
    }
}
