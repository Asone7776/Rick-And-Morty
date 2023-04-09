//
//  RMSearchResultView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 08/04/23.
//

import UIKit

/// Show search result table view or collection view as needed

protocol RMSearchResultsViewDelegate: AnyObject{
    func rmSearchResultsView(_ view:RMSearchResultsView,didTapLocation with: RMLocation)
}
final class RMSearchResultsView: UIView {
    
    weak var delegate: RMSearchResultsViewDelegate?
    
    private var locationModels: [RMLocationTableViewCellViewModel] = []
    private var collectionModels: [any Hashable] = []
    private var typeOfCollectionData: RMEndpoint = .character
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10);
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collection.isHidden = true;
        collection.alpha = 0;
        collection.showsVerticalScrollIndicator = false;
        collection.translatesAutoresizingMaskIntoConstraints = false;
        collection.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier);
        collection.register(RMEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeCollectionViewCell.identifier);
        collection.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collection;
    }();
    
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped);
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "location-cell")
        table.isHidden = true
        table.alpha = 0
        table.rowHeight = RMLocationTableViewCell.rowHeight
        table.backgroundColor = .systemBackground
        return table
    }();
    
    private var viewModel:RMSearchResultsViewModel? {
        didSet{
            processViewModel()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    private func processViewModel(){
        guard let model = viewModel else{
            return
        }
        switch model {
        case .characters(let characters):
            typeOfCollectionData = .character
            configureCollectionView(with: characters)
            break
        case .episodes(let episodes):
            typeOfCollectionData = .episode
            configureCollectionView(with: episodes)
            break
        case .locations(let locations):
            configureTableView(with: locations)
            break
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(){
        isHidden = false
    }
    
    public func hide(){
        isHidden = true
    }
    
    private func configureCollectionView(with models: [any Hashable]) {
        collectionModels = models
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        self.showCollectionView()
        UIView.animate(withDuration: 0.2) {
            self.collectionView.alpha = 1
        }
    }
    
    private func configureTableView(with locations:[RMLocationTableViewCellViewModel]) {
        self.locationModels = locations
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        self.showTableView()
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 1
        }
    }
    
    private func showCollectionView(){
        collectionView.isHidden = false
        tableView.isHidden = true
    }
    
    private func showTableView(){
        collectionView.isHidden = true
        tableView.isHidden = false
    }
}
extension RMSearchResultsView {
    private func style(){
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubviews(tableView, collectionView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    public func configure(with viewModel:RMSearchResultsViewModel){
        self.viewModel = viewModel
    }
}

extension RMSearchResultsView:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationModels.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.identifier) as? RMLocationTableViewCell else{
            fatalError("There is no such table cell")
        }
        let item = locationModels[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = locationModels[indexPath.row]
        let location = item.location
        delegate?.rmSearchResultsView(self, didTapLocation: location)
    }
}
extension RMSearchResultsView:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if typeOfCollectionData == .character{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else{
                fatalError("no such cell")
            }
            guard let item = collectionModels[indexPath.row] as? RMCharacterCollectionViewCellViewModel else{
                fatalError("no such model")
            }
            cell.configure(with: item)
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeCollectionViewCell.identifier, for: indexPath) as? RMEpisodeCollectionViewCell else{
                fatalError("no such cell")
            }
            guard let item = collectionModels[indexPath.row] as? RMEpisodeCollectionViewCellViewModel else{
                fatalError("no such model")
            }
            cell.configure(with: item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isCharacter = typeOfCollectionData == .character
        let bounds = UIScreen.main.bounds;
        let width = isCharacter ? (bounds.width - 30) / 2 : (bounds.width - 20);
        let height = isCharacter ? width * 1.5 : 150
        return CGSize(width: width, height: height );
    }
}
