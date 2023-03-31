//
//  RMSettingsViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//
import StoreKit
import SafariServices
import UIKit

final class RMSettingsViewController: UIViewController {
    
    let tableView = RMSettingsView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        layout()
    }
    private func layout() {
        view.addSubview(tableView);
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension RMSettingsViewController: RMSettingsViewDelegate{
    func didSelectUrl( url: URL) {
        let vc = SFSafariViewController(url: url);
        present(vc,animated: true);
    }
    func didRatePressed() {
        if let windowScene = view.window?.windowScene{
            SKStoreReviewController.requestReview(in: windowScene);
        }
    }
}

