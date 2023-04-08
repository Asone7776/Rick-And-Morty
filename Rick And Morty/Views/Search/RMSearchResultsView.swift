//
//  RMSearchResultView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 08/04/23.
//

import UIKit

/// Show search result table view or collection view as needed

final class RMSearchResultsView: UIView {
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
            configureCollectionView()
            break
        case .episodes(let episodes):
            configureCollectionView()
            break
        case .locations(let locations):
            configureTableView()
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
    
    private func configureCollectionView() {
        
    }
    
    private func configureTableView() {
        
    }
}
extension RMSearchResultsView {
    private func style(){
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
    }
    private func layout(){
        
    }
    public func configure(with viewModel:RMSearchResultsViewModel){
        self.viewModel = viewModel
    }
}
