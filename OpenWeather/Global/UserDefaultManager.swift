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
    
    private init() {
        lastSearchCityId = 1835847
        lastSearchCityLatitude = 37.583328
        lastSearchCityLongitude = 127.0
    }
    
    var lastSearchCityId: Int {
        get {
            userDefaults.integer(forKey: "lastSearchCityId")
        }
        
        set {
            userDefaults.set(newValue, forKey: "lastSearchCityId")
        }
    }
    
    var lastSearchCityLatitude: Double {
        get {
            userDefaults.double(forKey: "lastSearchCityLatitude")
        }
        
        set {
            userDefaults.set(newValue, forKey: "lastSearchCityLatitude")
        }
    }
    
    var lastSearchCityLongitude: Double {
        get {
            userDefaults.double(forKey: "lastSearchCityLongitude")
        }
        
        set {
            userDefaults.set(newValue, forKey: "lastSearchCityLongitude")
        }
    }
}
