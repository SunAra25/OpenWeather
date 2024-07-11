//
//  UserDefaultManager.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
    var lastSearchCity: Int {
        get {
            userDefaults.integer(forKey: "lastSearchCity")
        }
        
        set {
            userDefaults.set(newValue, forKey: "lastSearchCity")
        }
    }
}
