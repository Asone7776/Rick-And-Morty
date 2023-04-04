//
//  RMSearchViewController.swift
//  Rick And Morty
//
//  Created by Uzkassa on 30/03/23.
//

import UIKit

final class RMSearchViewController: UIViewController {
    private let viewModel:RMSearchViewViewModel
    private let baseSearchView:RMSearchView
    struct Config {
        enum `Type`{
            case character // name|status|gender
            case episode // name
            case location // name|type
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .episode:
                    return "Search Episodes"
                case .location:
                    return "Search Locations"
                }
            }
        }
        let type: `Type`
    }
    
    
    init(config: Config){
        self.viewModel = RMSearchViewViewModel(config: config)
        self.baseSearchView = RMSearchView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseSearchView.delegate = self
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        layout()
        addSearchItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        baseSearchView.presentKeyboard()
    }
}
extension RMSearchViewController{
    private func layout(){
        view.addSubview(baseSearchView);
        NSLayoutConstraint.activate([
            baseSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            baseSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            baseSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            baseSearchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func addSearchItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(onSearch))
    }
    @objc private func onSearch(){
        
    }
}
extension RMSearchViewController: RMSearchViewDelegate{
    func rmSearchView(_ view: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOptions) {
            print(view,option,separator: "|")
    }
}
