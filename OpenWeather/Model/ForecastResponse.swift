//
//  ForecastResponse.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

struct ForecastResponse: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
}

struct List: Decodable {
    let dt: Int
    let main: Info
    let weather: [Weather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }
}
