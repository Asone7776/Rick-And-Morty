//
//  ViewController.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import UIKit

final class RMTabViewController: UITabBarController {
    let charactersVC = RMCharacterViewController();
    let episodesVC = RMEpisodeViewController();
    let locationsVC = RMLocationViewController();
    let settingsVC = RMSettingsViewController();
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        setupTabs();
        setupTabBarAppearance();
    }
}
extension RMTabViewController{
    private func setupTabBarAppearance(){
        let appearance = UITabBarAppearance();
        appearance.shadowColor = .clear
        tabBar.standardAppearance = appearance;
        tabBar.scrollEdgeAppearance = appearance
    }
    private func setupTabs(){
        tabBar.isTranslucent = false;
        charactersVC.setTabBarImage(imageName: "person.fill", title: "Characteristics", tag: 0);
        episodesVC.setTabBarImage(imageName: "tv", title: "Episodes", tag: 1);
        locationsVC.setTabBarImage(imageName: "globe", title: "Locations", tag: 2);
        settingsVC.setTabBarImage(imageName: "gear", title: "Settings", tag: 3);
        
        charactersVC.setupTitleAndBackground(title: "Characters");
        episodesVC.setupTitleAndBackground(title: "Episodes");
        locationsVC.setupTitleAndBackground(title: "Locations");
        settingsVC.setupTitleAndBackground(title: "Settings");
        let navControllers = [
            UINavigationController(rootViewController: charactersVC),
            UINavigationController(rootViewController: episodesVC),
            UINavigationController(rootViewController: locationsVC),
            UINavigationController(rootViewController: settingsVC)
        ]
        navControllers.forEach { nav in
            nav.navigationItem.largeTitleDisplayMode = .automatic
            nav.navigationBar.prefersLargeTitles = true;
        }
        setViewControllers(
            navControllers,
            animated: false)
    }
}
