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
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailcell", for: indexPath);
        if indexPath.section == 0{
            cell.backgroundColor = .systemPink;
        }
        else if indexPath.section == 1{
            cell.backgroundColor = .systemBlue;
        }else{
            cell.backgroundColor = .systemCyan;
        }
        return cell;
    }
}
extension RMCharacterDetailViewController:UICollectionViewDelegate{
    
}
