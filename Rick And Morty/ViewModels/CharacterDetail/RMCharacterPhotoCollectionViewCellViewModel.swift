//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel{
    public let imageUrl:URL?;
    init(imageUrl:URL?) {
        self.imageUrl = imageUrl;
    }
    func fetchImage(completion:@escaping (Result<Data,Error>)->Void){
        guard let url = self.imageUrl else{
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion);
    }
}
