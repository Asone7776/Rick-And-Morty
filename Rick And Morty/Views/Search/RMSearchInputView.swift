//
//  RMSearchInputView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject{
    func rmSearchInputView(_ inputView:RMSearchInputView,didSelectOption options: RMSearchInputViewViewModel.DynamicOption)
    func rmSearchInputView(_ inputView:RMSearchInputView,didChangeSearch text:String)
    func rmSearchInputDidTapSearchButton(_ inputView:RMSearchInputView)
}

final class RMSearchInputView: UIView {
    
    weak var delegate: RMSearchInputViewDelegate?
    
    private var stackView:UIStackView?
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet{
            guard let viewModel = viewModel else{
                return
            }
            searchBar.delegate = viewModel
            searchBar.placeholder = viewModel.placeholder
            if viewModel.hasDynamicOptions{
                let options = viewModel.options
                self.createOptions(with: options)
            }
            viewModel.registerForTextChange {[weak self] textChange in
                guard let self = self else{
                    return
                }
                self.delegate?.rmSearchInputView(self, didChangeSearch: textChange)
            }
            viewModel.registerForSearchTapped {
                self.delegate?.rmSearchInputDidTapSearchButton(self);
            }
        }
    }
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.searchBarStyle = .minimal
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
        ])
    }
    private func createStackView() -> UIStackView {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        view.alignment = .center
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            view.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return view;
    }
    private func createOptions(with options:[RMSearchInputViewViewModel.DynamicOption]){
        guard !options.isEmpty else{
            return
        }
        let stackView = createStackView()
        self.stackView = stackView
        for (index,option) in options.enumerated() {
            let button = UIButton()
            let spacing: CGFloat = 8
            button.tag = index
            button.setTitle(option.rawValue, for: .normal)
            button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle")?.withTintColor(.label,renderingMode: .alwaysOriginal), for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.setTitleColor(.label, for: .highlighted)
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(onFilterButtonTapped), for: .touchUpInside)
            if #available(iOS 15, *) {
                var configuration = UIButton.Configuration.gray()
                configuration.imagePlacement = .trailing
                configuration.imagePadding = 8.0
                button.configuration = configuration
            } else {
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
                button.backgroundColor = .systemGray5
            }
            stackView.addArrangedSubview(button)
        }
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    @objc private func onFilterButtonTapped(_ button: UIButton){
        guard let viewModel = viewModel else{
            return
        }
        let tag = button.tag
        let option = viewModel.options[tag]
        delegate?.rmSearchInputView(self, didSelectOption: option)
    }
    public func update(option:RMSearchInputViewViewModel.DynamicOption,value: String){
        guard let buttons = stackView?.arrangedSubviews as? [UIButton],let options = viewModel?.options,let index = options.firstIndex(of: option) else {
            return
        }
        let button = buttons[index];
        button.setTitle(value.capitalized, for: .normal)
    }
}
