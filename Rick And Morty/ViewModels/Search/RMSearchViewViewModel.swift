//
//  RMSearchViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMSearchViewViewModel {
    
    let config:RMSearchViewController.Config
    
    private var searchResultHandler: ((RMSearchResultsViewModel) -> Void)?
    
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var optionsMap: [RMSearchInputViewViewModel.DynamicOption:String] = [:]
    
    private var searchText:String = ""
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    public func set(value:String,for option: RMSearchInputViewViewModel.DynamicOption){
        optionsMap[option] = value
        let tuple = (option, value);
        optionMapUpdateBlock?(tuple);
    }
    
    public func set(text:String){
        self.searchText = text
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void ){
        self.optionMapUpdateBlock = block
    }
    
    public func registerForSearchResult(_ block: @escaping (RMSearchResultsViewModel) -> Void){
        self.searchResultHandler = block
    }
    
    public func executeSearch() {
        var optionsForSearch = [URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]
        optionsMap.forEach { option in
            optionsForSearch.append(URLQueryItem(name: option.key.rawValue.lowercased(), value: option.value))
        }
        let request = RMRequest(endpoint: config.type.endpoint,queryParameters: optionsForSearch)
            
        switch config.type.endpoint{
        case .character:
            self.makeSearchAPICall(RMGetAllCharactersResponse.self, request: request)
        case .episode:
            self.makeSearchAPICall(RMGetAllEpisodesResponse.self, request: request)
        case .location:
            self.makeSearchAPICall(RMGetAllLocationsResponse.self, request: request)
        }
    }
    private func makeSearchAPICall<T: Codable>(_ type: T.Type, request: RMRequest){
        RMService.shared.execute(request, expecting: type ) {[weak self] result in
            switch result {
            case .success(let model):
                self?.processSearchResult(model: model)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func processSearchResult(model: Codable){
        var resultsVM:RMSearchResultsViewModel?
        if let charactesModel = model as? RMGetAllCharactersResponse {
            resultsVM = .characters(charactesModel.results.compactMap({ character in
                RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
            }))
        }else if let episodeModel = model as? RMGetAllEpisodesResponse {
            resultsVM = .episodes(episodeModel.results.compactMap({ episode in
                RMEpisodeCollectionViewCellViewModel(name: episode.name, air_date: episode.air_date, episode: episode.episode)
            }))
        }else if let locationModel = model as? RMGetAllLocationsResponse {
            resultsVM = .locations(locationModel.results.compactMap({ location in
                RMLocationTableViewCellViewModel(location: location)
            }))
        }
        if let result = resultsVM{
            self.searchResultHandler?(result)
        }else{
            print("Error")
        }
    }
}
