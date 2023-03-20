//
//  RMCharacterViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    private let characterView = CharacterListView();
    override func viewDidLoad() {
        super.viewDidLoad();
        layout();
    }
}
extension RMCharacterViewController{
    func layout(){
        view.addSubview(characterView);
        NSLayoutConstraint.activate([
            characterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
