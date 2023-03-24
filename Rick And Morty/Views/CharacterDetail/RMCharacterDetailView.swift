//
//  RMCharacterDetailView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 21/03/23.
//

import UIKit
/// View for single character
final class RMCharacterDetailView: UIView {
    
    private var viewModel:RMCharacterDetailViewViewModel?
    
    public lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,_ in
            return self.createSection(for: sectionIndex)
        }
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collection.translatesAutoresizingMaskIntoConstraints = false;
        collection.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier)
        collection.register(RMCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier)
        collection.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier)
        return collection;
    }();
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large);
        view.hidesWhenStopped = true;
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RMCharacterDetailView{
    private func layout(){
        translatesAutoresizingMaskIntoConstraints = false;
        addSubviews(collectionView,spinner);
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]);
    }
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection{
        guard let model = viewModel else{
            return dummySection();
        }
        switch model.sections[sectionIndex]{
        case .photo:
            return model.createPhotoSection()
        case .information:
            return model.createInfoSection()
        case.episodes:
            return model.createEpisodesSection()
        }
    }
    
    public func dummySection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0);
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section;
    }
    
    public func configure(with model:RMCharacterDetailViewViewModel){
        self.viewModel = model;
    }
}

