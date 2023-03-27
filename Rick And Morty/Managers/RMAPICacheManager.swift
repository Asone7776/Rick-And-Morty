//
//  RMAPICacheManager.swift
//  Rick And Morty
//
//  Created by Uzkassa on 27/03/23.
//

import Foundation


final class RMAPICacheManager {
    private var cache = NSCache<NSString, NSData>()
    
    private var cacheDictionary = [String: NSCache<NSString, NSData>]();
    
    init(){
        
    }
}
