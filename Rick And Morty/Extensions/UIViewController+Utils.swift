//
//  UIViewController+Utils.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 18/03/23.
//

import UIKit

extension UIViewController{
    func setTabBarImage(imageName:String,title:String,tag:Int){
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    }
    func setupTitleAndBackground(title:String){
        self.title = title;
        self.view.backgroundColor = .systemBackground;
        self.navigationItem.largeTitleDisplayMode = .automatic;
    }
}
