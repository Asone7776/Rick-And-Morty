//
//  RMSettingsView.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 31/03/23.
//

import SwiftUI

struct RMSettingsViewUI: View {
    let viewModel:RMSettingsViewViewModel
    
    init(viewModel:RMSettingsViewViewModel){
        self.viewModel = viewModel
    }
    var body: some View {
        List(viewModel.cellViewModels) { item in
            Text(item.title)
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsViewUI(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({ type in
            return RMSettingsCellViewModel(type: type)
        })))
    }
}
