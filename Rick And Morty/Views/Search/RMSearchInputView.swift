//
//  RMSearchInputView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMSearchInputView: UIView {
    
    private var viewModel:RMSearchInputViewViewModel?{
        didSet{
            guard let viewModel = viewModel,viewModel.hasDynamicOptions else{
                return
            }
            searchBar.placeholder = viewModel.placeholder
            let options = viewModel.options
            self.createOptions(with: options)
        }
    }
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("No such view")
    }
    public func configure(with model:RMSearchInputViewViewModel){
        self.viewModel = model
    }
}
extension RMSearchInputView {
    private func style(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            searchBar.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: searchBar.trailingAnchor, multiplier: 1),
            searchBar.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    private func createOptions(with options:[RMSearchInputViewViewModel.DynamicOptions]){
        options.forEach { option in
            print(option.rawValue)
        }
    }
}
