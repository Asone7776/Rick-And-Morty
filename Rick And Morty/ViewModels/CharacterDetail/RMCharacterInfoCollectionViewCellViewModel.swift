//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Uzkassa on 24/03/23.
//

import Foundation
final class RMCharacterInfoCollectionViewCellViewModel{
    public let value:String
    public let title:String
    init(value:String,title:String){
        self.value = value
        self.title = title
    }
}
