//
//  RMLocationViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import UIKit

final class RMLocationViewController: UIViewController {

    let locationView = RMLocationView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.delegate = self;
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(onSearch))
        layout()
    }
    private func layout(){
        view.addSubview(locationView);
        NSLayoutConstraint.activate([
            locationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            locationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    @objc private func onSearch(){
        let vc = RMSearchViewController(config: .init(type: .location))
        navigationController?.pushViewController(vc, animated: true);
    }
}

extension RMLocationViewController: RMLocationViewDelegate{
    func didSelectLocation(_ view: RMLocationView, location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location);
        navigationController?.pushViewController(vc, animated: true);
    }
}
