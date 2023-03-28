//
//  RMAPICacheManager.swift
//  Rick And Morty
//
//  Created by Uzkassa on 27/03/23.
//

import Foundation


final class RMAPICacheManager {
    private var cache = NSCache<NSString, NSData>()
    
    private var cacheDictionary = [RMEndpoint: NSCache<NSString, NSData>]();
    
    init(){
        setupCache();
    }
    
    private func setupCache(){
        RMEndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString,NSData>();
        }
    }
    
    public func setCache(for endpoint:RMEndpoint,url:URL?,data:Data){
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return;
        }
        let key = url.absoluteString as NSString;
        let obj = data as NSData;
        targetCache.setObject(obj, forKey: key);
    }
    
    public func getCachedResponse(for endpoint:RMEndpoint, url:URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint],let url = url else{
            return nil;
        }
        let key = url.absoluteString as NSString;
        let cache = targetCache.object(forKey: key);
        return cache as Data?;
    }
}
