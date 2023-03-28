//
//  RMEpisodeViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import UIKit

final class RMEpisodeViewController: UIViewController {
    

    private let episodeView = RMEpisodeListView();
    override func viewDidLoad() {
        super.viewDidLoad();
        episodeView.delegate = self;
        layout();
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        episodeView.collectionView.collectionViewLayout.invalidateLayout()
    }

}

extension RMEpisodeViewController{
    func layout(){
        view.addSubview(episodeView);
        NSLayoutConstraint.activate([
            episodeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


////MARK: - RMCharacterListViewDelegate
extension RMEpisodeViewController: RMEpisodeListViewDelegate{
    func rmEpisodeListView(_ episodeListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let viewModel = RMEpisodeDetailViewViewModel(episodeUrl: URL(string: episode.url));
        let detailVc = RMEpisodeDetailViewController(url: viewModel.episodeUrl);
        navigationController?.pushViewController(detailVc, animated: true);
    }
}

