//
//  RMCharacterDetailViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 21/03/23.
//

import Foundation

final class RMCharacterDetailViewViewModel{
    private let character:RMCharacter
    init(character:RMCharacter){
        self.character = character;
    }
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    public let sections = SectionType.allCases;
    
    public var title:String {
        character.name.uppercased();
    }
//    private var requestUrl:URL?{
//        return URL(string: character.url);
//    }
//
//    public func fetchCharacterInfo(){
//        guard let url = requestUrl, let request = RMRequest(url: url) else{
//            return;
//        }
//        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
//            switch result {
//            case .success(let character):
//                print(character);
//            case .failure(let failure):
//                print(failure);
//            }
//        }
//    }
}
