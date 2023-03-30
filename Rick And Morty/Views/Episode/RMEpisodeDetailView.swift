//
//  RMEpisodeDetailView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//

import UIKit

protocol RMEpisodeDetailViewDelegate: AnyObject {
    func rmEpisodeDetailView(_ detailView:RMEpisodeDetailView, didSelect character:RMCharacter)
}

final class RMEpisodeDetailView: UIView {
    
    public weak var delegate:RMEpisodeDetailViewDelegate?
    
    private var viewModel:RMEpisodeDetailViewViewModel?{
        didSet {
            self.spinner.stopAnimating();
            self.collectionView.reloadData();
            self.collectionView.isHidden = false;
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.collectionView.alpha = 1;
            }
        }
    }
    
    public let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large);
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        spinner.hidesWhenStopped = true;
        return spinner
    }();
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout {section, _ in
            self.initialLayout(with: section);
        }
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collection.showsVerticalScrollIndicator = false;
        collection.translatesAutoresizingMaskIntoConstraints = false;
        collection.isHidden = true;
        collection.alpha = 0;
        collection.delegate = self;
        collection.dataSource = self;
        collection.register(RMEpisodeDetailCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeDetailCollectionViewCell.identifier)
        collection.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        return collection;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        style();
        layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RMEpisodeDetailView{
    private func style(){
        spinner.startAnimating();
        translatesAutoresizingMaskIntoConstraints = false;
    }
    
    private func layout(){
        addSubviews(collectionView,spinner);
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with model: RMEpisodeDetailViewViewModel){
        self.viewModel = model;
    }
}

extension RMEpisodeDetailView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = viewModel else {
            return 0
        }
        switch model.sections[section]{
        case .characters(let characters):
            return characters.count
        case .information(let information):
            return information.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let model = viewModel else {
            fatalError("No view model");
        }
        switch model.sections[indexPath.section]{
        case .characters(let characters):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
                fatalError("There is no such cell");
            }
            cell.configure(with: characters[indexPath.row]);
            return cell;
        case .information(let information):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeDetailCollectionViewCell.identifier, for: indexPath) as? RMEpisodeDetailCollectionViewCell else {
                fatalError("There is no such cell");
            }
            cell.configure(with: information[indexPath.row]);
            return cell;
        }
    }
}

extension RMEpisodeDetailView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true);
        guard let model = viewModel else {
            return
        }
        
        switch model.sections[indexPath.section]{
        case .characters:
            guard let character = viewModel?.getCharacter(at: indexPath.row) else {
                return
            }
            delegate?.rmEpisodeDetailView(self, didSelect: character)
        case .information:
            break
        }
    }
}

//MARK: Layouts for collection view

extension RMEpisodeDetailView{
    
    private func initialLayout(with sectionIndex: Int) -> NSCollectionLayoutSection {
        guard let data = viewModel?.sections else{
            return infoLayout(with: sectionIndex);
        }
        switch data[sectionIndex]{
            case .information:
            return infoLayout(with: sectionIndex);
            case .characters:
            return charactersLayout(with: sectionIndex)
        }
    }
    
    private func infoLayout(with sectionIndex: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10);
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100));
        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item]);
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0);
        let section = NSCollectionLayoutSection(group: group);
        return section;
    }
    
    private func charactersLayout(with sectionIndex: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10);
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section;
    }
}
