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
    
    var lastSearchCityId: Int {
        get {
            let id = userDefaults.integer(forKey: "lastSearchCityId")
            return id == 0 ? 1835847 : id
        }
        
        set {
            userDefaults.set(newValue, forKey: "lastSearchCityId")
        }
    }
    
    var lastSearchCityLatitude: Double {
        get {
            let latitude = userDefaults.double(forKey: "lastSearchCityLatitude")
            return latitude == 0 ? 37.583328 : latitude
        }
        
        set {
            userDefaults.set(newValue, forKey: "lastSearchCityLatitude")
        }
    }
    
    var lastSearchCityLongitude: Double {
        get {
            let longitude = userDefaults.double(forKey: "lastSearchCityLongitude")
            return longitude == 0 ? 127.0 : longitude
        }
        
        set {
            userDefaults.set(newValue, forKey: "lastSearchCityLongitude")
        }
    }
}
