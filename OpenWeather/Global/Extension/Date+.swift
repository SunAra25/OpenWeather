//
//  Date+.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func withoutTime() -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components)
    }
    
    func afterNdays(_ n: Int) -> Date? {
        let date = Calendar.current.date(byAdding: .day, value: n, to: self)
        return date
    }
    
    func weekend() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
