//
//  RMService.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation


/// Primary API Service object to get Rick and Morty data
final class RMService {
    static let shared = RMService();
    private init(){
        
    }
    public func execute<T:Codable>(_ request:RMRequest,expecting type:T.Type, completion:@escaping (Result<T,Error>) -> Void){
        
    }
}
