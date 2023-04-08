//
//  RMSearchView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject{
    func rmSearchView(_ view:RMSearchView,didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

final class RMSearchView: UIView {
    weak var delegate: RMSearchViewDelegate?
    
    private let viewModel:RMSearchViewViewModel
    private let noSearchView = RMNoSearchResultView()
    private let searchInputView = RMSearchInputView()
    private let resultsView = RMSearchResultsView();
    
    init(viewModel:RMSearchViewViewModel) {
        self.viewModel = viewModel
        searchInputView.configure(with: .init(type: viewModel.config.type))
        super.init(frame: .zero)
        searchInputView.delegate = self
        style()
        layout()
        registerHandlers(viewModel: viewModel)
    }
    
    private func registerHandlers(viewModel: RMSearchViewViewModel){
        viewModel.registerOptionChangeBlock {tuple in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
        viewModel.registerForSearchResult {[weak self] result in
            DispatchQueue.main.async {
                guard let model = result else{
                    self?.noSearchView.show()
                    self?.resultsView.hide()
                    return
                }
                self?.resultsView.configure(with: model)
                self?.noSearchView.hide()
                self?.resultsView.show()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RMSearchView {
    private func style(){
        backgroundColor = .systemBackground
    }
    private func layout(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(resultsView, noSearchView, searchInputView)
        NSLayoutConstraint.activate([
            noSearchView.widthAnchor.constraint(equalToConstant: 150),
            noSearchView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            noSearchView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noSearchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),
            
            resultsView.topAnchor.constraint(equalTo: searchInputView.bottomAnchor),
            resultsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            resultsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            resultsView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    public func presentKeyboard(){
        searchInputView.presentKeyboard()
    }
}

extension RMSearchView:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension RMSearchView: RMSearchInputViewDelegate{
    func rmSearchInputDidTapSearchButton(_ inputView: RMSearchInputView) {
        print("tapped");
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearch text: String) {
        viewModel.set(text: text)
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
    
}
