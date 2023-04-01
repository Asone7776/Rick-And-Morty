//
//  RMSettingsCellViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 31/03/23.
//

import UIKit

struct RMSettingsCellViewModel {
    public var image: UIImage?{
        type.iconImage
    }
    public var title: String {
        type.displayTitie
    }
    
    public var iconColor:UIColor{
        type.iconContainerColor
    }
    
    public let type:RMSettingsOption
    
    init(type: RMSettingsOption) {
        self.type = type
    }
}
