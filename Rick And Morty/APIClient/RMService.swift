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
    
    private let cacheManager = RMAPICacheManager();
    
    enum RMServiceError:Error{
        case failedToCreateRequest
        case failedToGetData
    }
    private init(){
        
    }
    public func execute<T:Codable>(_ request:RMRequest,expecting type:T.Type, completion: @escaping (Result<T,Error>) -> Void){
        guard let urlRequest = self.request(from: request) else{
            completion(.failure(RMServiceError.failedToCreateRequest))
            return;
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else{
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return;
            }
            do {
                let result = try JSONDecoder().decode(type.self, from: data);
                completion(.success(result));
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume();
    }
    private func request(from rmRequest:RMRequest) -> URLRequest?{
        guard let url = rmRequest.url else { return nil };
        var request = URLRequest(url: url);
        request.httpMethod = rmRequest.httpMethod;
        return request;
    }
}
