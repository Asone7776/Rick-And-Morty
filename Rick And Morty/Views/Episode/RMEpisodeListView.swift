//
//  RMEpisodeListView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 28/03/23.
//
import UIKit

protocol RMEpisodeListViewDelegate: AnyObject{
    func rmEpisodeListView(_ episodeListView:RMEpisodeListView,didSelectEpisode episode:RMEpisode)
}

final class RMEpisodeListView: UIView {
    
    public weak var delegate: RMEpisodeListViewDelegate?
    
    private let viewModel = RMEpisodeListViewViewModel();
    
    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large);
        view.hidesWhenStopped = true;
        view.translatesAutoresizingMaskIntoConstraints = false;
        return view;
    }();
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10);
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collection.isHidden = true;
        collection.alpha = 0;
        collection.showsVerticalScrollIndicator = false;
        collection.translatesAutoresizingMaskIntoConstraints = false;
        collection.register(RMEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeCollectionViewCell.identifier);
        collection.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collection;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        viewModel.delegate = self;
        viewModel.fetchEpisodes();
        style();
        layout();
        setupCollectionView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension RMEpisodeListView{
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false;
    }
    private func layout(){
        addSubviews(collectionView, spinner);
        spinner.startAnimating();
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]);
    }
    private func setupCollectionView(){
        collectionView.dataSource = viewModel;
        collectionView.delegate = viewModel;
    }

    
}
extension RMEpisodeListView:RMEpisodeListViewViewModelDelegate{
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didLoadInitialCharacters() {
        self.collectionView.reloadData();
        self.collectionView.isHidden = false;
        self.spinner.stopAnimating();

        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = 1;
        }
    }
    func didSelectEpisode(episode: RMEpisode) {
        delegate?.rmEpisodeListView(self, didSelectEpisode: episode);
    }
}

