//
//  RMSearchInputViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMSearchInputViewViewModel: NSObject {
    private let type:RMSearchViewController.Config.`Type`;
    private var textChangeHandler: ((String)->Void)?
    private var searchTappedHandler: (()->Void)?
    
    enum DynamicOption: String{
        case status = "Status"
        case gender = "Gender"
        case type = "Location Type"
        
        var choises:[String]{
            switch self{
            case .status:
                return ["alive","dead","unknown"]
            case .gender:
                return ["male","female","genderless","unknown"]
            case .type:
                return ["planet","microverse","cluster","unknown"]
            }
        }
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
    public var options: [DynamicOption]{
        switch type{
        case .character:
            return [.status,.gender]
        case .location:
            return [.type]
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
    
    public func registerForTextChange(_ block: @escaping (String) -> Void){
        self.textChangeHandler = block
    }
    
    public func registerForSearchTapped(_ block: @escaping () -> Void){
        self.searchTappedHandler = block
    }
}
extension RMSearchInputViewViewModel:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textChangeHandler?(searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true);
        searchTappedHandler?()
    }
}
