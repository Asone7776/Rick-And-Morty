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
    private func setupNavigations(){
    
    }
    private func setupTabs(){
        tabBar.isTranslucent = false;
        charactersVC.setTabBarImage(imageName: "person.fill", title: "Characteristics", tag: 0);
        episodesVC.setTabBarImage(imageName: "tv", title: "Episodes", tag: 1);
        locationsVC.setTabBarImage(imageName: "globe", title: "Locations", tag: 2);
        settingsVC.setTabBarImage(imageName: "gear", title: "Settings", tag: 3);
        
        charactersVC.setupTitleAndBackground(title: "Characteristics");
        episodesVC.setupTitleAndBackground(title: "Episodes");
        locationsVC.setupTitleAndBackground(title: "Locations");
        settingsVC.setupTitleAndBackground(title: "Settings");
        let charactersNV = UINavigationController(rootViewController: charactersVC);
        let episodesNV = UINavigationController(rootViewController: episodesVC);
        let locationsNV = UINavigationController(rootViewController: locationsVC);
        let settingsNV = UINavigationController(rootViewController: settingsVC);
        for nav in  [charactersNV,locationsNV,episodesNV,settingsNV]{
            nav.navigationBar.prefersLargeTitles = true;
        }
        setViewControllers(
            [charactersNV,episodesNV,locationsNV,settingsNV],
            animated: false)
    }
}
