//
//  RMLocationDetailViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import UIKit

final class RMLocationDetailViewController: UIViewController {
    
    private let location: RMLocation
    
    init(location:RMLocation) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = location.name
        navigationItem.largeTitleDisplayMode = .never
        style()
        layout()
    }
}
extension RMLocationDetailViewController{
    private func style(){
        view.backgroundColor = .systemBackground
    }
    private func layout(){
        
    }
}
