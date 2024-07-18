//
//  String+.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        _DateFormatter.standard.dateFormat = _DateFormatter.dateWithTime.rawValue
        return _DateFormatter.standard.date(from: self)
    }
}
