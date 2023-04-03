//
//  RMLocationDetailView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 01/04/23.
//

import UIKit

class RMLocationDetailView: UIView {
    
    private var viewModel:RMLocationDetailViewViewModel?{
        didSet{
            spinner.startAnimating();
            viewModel?.fetchRelatedCharacters();
            viewModel?.delegate = self;
        }
    }
    
    public let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large);
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        spinner.hidesWhenStopped = true;
        return spinner
    }();
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout {section, _ in
            self.initialLayout(with: section);
        }
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout);
        view.dataSource = self;
        view.delegate = self;
        view.isHidden = true;
        view.alpha = 0;
        view.register(RMEpisodeDetailCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeDetailCollectionViewCell.identifier)
        view.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RMLocationDetailView{
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubviews(collectionView,spinner);
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    public func configure(with model:RMLocation){
        self.viewModel = .init(location: model)
    }
}

extension RMLocationDetailView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel?.sections.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = viewModel?.sections else{
            return 0
        }
        switch model[section]{
        case .information(let informations):
            return informations.count
        case .residents(let residets):
            return residets.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = viewModel else {
            fatalError("No view model");
        }
        switch model.sections[indexPath.section]{
        case .residents(let residents):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
                fatalError("There is no such cell");
            }
            cell.configure(with: residents[indexPath.row]);
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
extension RMLocationDetailView {
    private func initialLayout(with sectionIndex: Int) -> NSCollectionLayoutSection {
        guard let data = viewModel?.sections else{
            return infoLayout(with: sectionIndex);
        }
        switch data[sectionIndex]{
            case .information:
            return infoLayout(with: sectionIndex);
            case .residents:
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
extension RMLocationDetailView:RMLocationDetailViewViewModelDelegate{
    func didPrepareData() {
        spinner.stopAnimating();
        collectionView.reloadData();
        collectionView.isHidden = false;
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1;
        }
    }
}
