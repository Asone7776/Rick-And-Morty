//
//  RMSearchViewController.swift
//  Rick And Morty
//
//  Created by Uzkassa on 30/03/23.
//

import UIKit

final class RMSearchViewController: UIViewController {

    struct Config {
        enum `Type`{
            case character // name|status|gender
            case episode // name
            case location // name|type
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Search Location"
                }
            }
        }
        let type: `Type`
    }
    private let config:Config
    
    init(config: Config){
        self.config = config
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
}
