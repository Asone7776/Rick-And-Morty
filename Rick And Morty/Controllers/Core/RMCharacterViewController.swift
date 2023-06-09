//
//  RMCharacterViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import UIKit

final class RMCharacterViewController: UIViewController {
    private let characterView = RMCharacterListView();
    override func viewDidLoad() {
        super.viewDidLoad();
        characterView.delegate = self;
        addBarButton();
        layout();
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        characterView.collectionView.collectionViewLayout.invalidateLayout()
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
    
    private func addBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self , action: #selector(searchPressed))
    }
    @objc private func searchPressed(){
        let vc = RMSearchViewController(config: .init(type: .character));
        navigationController?.pushViewController(vc, animated: true);
    }
}
//MARK: - RMCharacterListViewDelegate
extension RMCharacterViewController: RMCharacterListViewDelegate{
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character);
        let detailVc = RMCharacterDetailViewController(viewModel: viewModel);
        navigationController?.pushViewController(detailVc, animated: true);
    }
}

