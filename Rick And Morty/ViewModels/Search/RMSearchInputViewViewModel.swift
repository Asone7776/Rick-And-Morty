//
//  RMSearchInputViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMSearchInputViewViewModel: NSObject {
    private let type:RMSearchViewController.Config.`Type`;
    
    enum DynamicOptions: String{
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    var hasDynamicOptions: Bool{
        switch type{
        case .character,.location:
            return true
        case .episode:
            return false
        }
    }
    public var options: [DynamicOptions]{
        switch type{
        case .character:
            return [.status,.gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    public var placeholder: String {
        switch type{
        case .character:
            return "Character name"
        case .location:
            return "Location name"
        case .episode:
            return "Episode name"
        }
    }
}
extension RMSearchInputViewViewModel:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true);
    }
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        guard let text = searchBar.text,text.isEmpty else {
//            return false
//        }
//        return true
//    }
}
