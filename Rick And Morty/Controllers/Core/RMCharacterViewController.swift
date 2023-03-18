//
//  RMCharacterViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = RMRequest(
            endpoint: .character,
            pathComponents: ["1"],
            queryParameters: [URLQueryItem(name: "name", value: "rick"),URLQueryItem(name: "status", value: "alive")]
        );
        print(request.url);
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
            switch result{
            case .success(let str):
                print(str)
            case .failure(let error):
                print(error);
            }
        }
    }
}
