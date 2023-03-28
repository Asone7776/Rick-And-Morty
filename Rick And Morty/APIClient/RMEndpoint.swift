//
//  RMEndpoint.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation

@frozen enum RMEndpoint: String, Hashable, CaseIterable {
    case character
    case location
    case episode
}
