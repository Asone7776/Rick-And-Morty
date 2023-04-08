//
//  RMSearchResultsViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 08/04/23.
//

import Foundation

enum RMSearchResultsViewModel{
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
