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
    
    public let endpoint:RMEndpoint
    
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
    convenience init?(url:URL){
        let string = url.absoluteString;
        if !string.contains(Constants.base_url){
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.base_url+"/", with: "")
        if trimmed.contains("/"){
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty{
                let endpointString = components[0];
                var pathComponents:[String] = [];
                if components.count > 1{
                    pathComponents = components;
                    pathComponents.removeFirst();
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString){
                    self.init(endpoint: rmEndpoint,pathComponents: pathComponents);
                    return;
                }
            }
        }else if trimmed.contains("?"){
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty{
                let endpointString = components[0];
                let queryItemsString = components[1];
                let queryParameters: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let path = $0.components(separatedBy: "=");
                    return URLQueryItem(name: path[0], value: path[1]);
                });
                if let rmEndpoint = RMEndpoint(rawValue: endpointString){
                    self.init(endpoint: rmEndpoint,queryParameters: queryParameters);
                    return;
                }
            }
        }
        return nil
    }
}
extension RMRequest{
    static let listCharactersRequest = RMRequest(endpoint: .character);
    static let listEpisodesRequest = RMRequest(endpoint: .episode);
    static let listLocationsRequest = RMRequest(endpoint: .location);
}
