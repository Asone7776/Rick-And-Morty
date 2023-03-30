//
//  RMEpisodeDetailViewController.swift
//  Rick And Morty
//
//  Created by Uzkassa on 26/03/23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    private let viewModel: RMEpisodeDetailViewViewModel
    private let detailView = RMEpisodeDetailView();
    
    init(url: URL?){
        self.viewModel = .init(episodeUrl: url);
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode";
        style();
        layout();
        detailView.delegate = self;
        viewModel.delegate = self;
        viewModel.fetchEpisode()
    }
    
}

extension RMEpisodeDetailViewController{
    private func style(){
        view.backgroundColor = .systemBackground
    }
    private func layout(){
        view.addSubview(detailView);
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension RMEpisodeDetailViewController:RMEpisodeDetailViewViewModelDelegate{
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}

extension RMEpisodeDetailViewController: RMEpisodeDetailViewDelegate{
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character));
        navigationController?.pushViewController(vc, animated: true);
    }
}
