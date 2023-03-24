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
    private let detailView = RMCharacterDetailView();
    
    init(viewModel:RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel;
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.configure(with: viewModel);
        detailView.collectionView.dataSource = self;
        detailView.collectionView.delegate = self;
        setupTitleAndBackground(title: viewModel.title)
        style();
        layout();
        addBarButton();
    }
}

extension RMCharacterDetailViewController{
    private func style(){
        navigationItem.largeTitleDisplayMode = .never;
    }
    private func layout(){
        view.addSubview(detailView);
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]);
    }
    private func addBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightButtonPressed))
    }
}
//MARK: Actions
extension RMCharacterDetailViewController{
    @objc private func rightButtonPressed(){
        print("touch");
    }
}

extension RMCharacterDetailViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section];
        switch sectionType{
        case .photo:
            return 1;
        case .episodes(let episodes):
            return episodes.count;
        case .information(let information):
            return information.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section]{
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell else{
                fatalError("Unsupported")
            }
            cell.configure(with: viewModel)
            return cell;
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier, for: indexPath) as? RMCharacterInfoCollectionViewCell else{
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell;
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else{
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell;
        }
    }
}
extension RMCharacterDetailViewController:UICollectionViewDelegate{
    
}
