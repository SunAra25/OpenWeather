//
//  Date+.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

extension Date {
    func toString() -> String {
        _DateFormatter.standard.timeStyle = .none
        _DateFormatter.standard.dateFormat = _DateFormatter.date.rawValue
        return _DateFormatter.standard.string(from: self)
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
        _DateFormatter.standard.dateFormat = _DateFormatter.weekend.rawValue
        _DateFormatter.standard.locale = Locale(identifier: "ko_KR")
        return _DateFormatter.standard.string(from: self)
    }
}
