//
//  RMSearchView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMSearchView: UIView {
    
    private let viewModel:RMSearchViewViewModel
    private let noSearchView = RMNoSearchResultView()
    
    init(viewModel:RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RMSearchView {
    private func style(){
        backgroundColor = .systemBackground
    }
    private func layout(){
        noSearchView.isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(noSearchView);
        NSLayoutConstraint.activate([
            noSearchView.widthAnchor.constraint(equalToConstant: 150),
            noSearchView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            noSearchView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noSearchView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

extension RMSearchView:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
