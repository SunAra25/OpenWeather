//
//  Formatter.swift
//  OpenWeather
//
//  Created by 아라 on 7/18/24.
//

import Foundation

enum _DateFormatter: String {
    static let standard = DateFormatter()
    
    case dateWithTime = "yyyy-MM-dd HH:mm:ss"
    case date = "yyyy-MM-dd"
    case weekend = "E"
}
