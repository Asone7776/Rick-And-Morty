//
//  RMEpisodeDetailViewController.swift
//  Rick And Morty
//
//  Created by Uzkassa on 26/03/23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    init(url: URL?){
        self.url = url
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        style();
    }
    
}

extension RMEpisodeDetailViewController{
    private func style(){
        view.backgroundColor = .systemBackground
    }
}
