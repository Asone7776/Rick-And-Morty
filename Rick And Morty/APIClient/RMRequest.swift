//
//  RMRequest.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import Foundation

final class RMRequest {
    
    private struct Constants{
        static let base_url = "https://rickandmortyapi.com/api";
    }
    
    private let endpoint:RMEndpoint
    
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    private var urlString:String{
        var string = Constants.base_url;
        string += "/"
        string += endpoint.rawValue;
        if !pathComponents.isEmpty{
            pathComponents.forEach { pathItem in
                string += "/\(pathItem)";
            }
        }
        if !queryParameters.isEmpty{
            string += "?";
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil};
                return "\($0.name)=\(value)";
            }).joined(separator: "&");
            string += argumentString;
        }
        return string;
    }
    public let httpMethod = "GET";
    public var url:URL? {
        URL(string: urlString);
    }
    
    public init(endpoint: RMEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}
extension RMRequest{
    static let listCharactersRequest = RMRequest(endpoint: .character);
}
