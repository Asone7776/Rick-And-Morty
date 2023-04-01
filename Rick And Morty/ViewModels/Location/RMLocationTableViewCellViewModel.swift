//
//  RMLocationTableViewCellViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import Foundation

struct RMLocationTableViewCellViewModel:Hashable, Equatable {
 
    private let location:RMLocation
    init(location: RMLocation) {
        self.location = location
    }
    public var name: String{
        location.name
    }
    public var type: String{
        "Type: " + location.type
    }
    public var dimension: String{
        "Dimension: " + location.dimension.capitalized
    }
    
    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location.id)
        hasher.combine(location.name)
        hasher.combine(location.type)
    }
}
