//
//  RMSearchViewViewModel.swift
//  Rick And Morty
//
//  Created by Arthur Obichkin on 03/04/23.
//

import UIKit

final class RMSearchViewViewModel {
    
    let config:RMSearchViewController.Config
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var optionsMap: [RMSearchInputViewViewModel.DynamicOption:String] = [:]
    
    private var searchText:String = ""
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    public func set(value:String,for option: RMSearchInputViewViewModel.DynamicOption){
        optionsMap[option] = value
        let tuple = (option, value);
        optionMapUpdateBlock?(tuple);
    }
    
    public func set(text:String){
        self.searchText = text
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void ){
        self.optionMapUpdateBlock = block
    }
    public func executeSearch() {
        print(optionsMap)
    }
}
