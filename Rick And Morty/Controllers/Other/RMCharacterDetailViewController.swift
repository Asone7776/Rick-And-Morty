//
//  RMDetailViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 21/03/23.
//

import UIKit
///Controller to show info about single character
final class RMCharacterDetailViewController: UIViewController {
    private let viewModel:RMCharacterDetailViewViewModel
    
    init(viewModel:RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel;
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleAndBackground(title: viewModel.title)
        navigationItem.largeTitleDisplayMode = .never;
    }
}
