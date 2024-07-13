//
//  Weather.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

struct OpenWeatherResponse: Codable {
    let weather: [Weather]
    let main: Info
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: System
    let timezone: Int
    let name: String
    let cod: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Info: Codable {
    let absTemp, absTempMin, absTempMax: Double
    let humidity, grndLevel: Int
    var temp: Double {
        let temp = absTemp - 273.15
        return round(temp * 100)/100
    }
    var tempMax: Double {
        let temp = absTempMax - 273.15
        return round(temp * 100)/100
    }
    var tempMin: Double {
        let temp = absTempMin - 273.15
        return round(temp * 100)/100
    }
    enum CodingKeys: String, CodingKey {
        case absTemp = "temp"
        case absTempMin = "temp_min"
        case absTempMax = "temp_max"
        case humidity
        case grndLevel = "grnd_level"
    }
}

struct System: Codable {
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}
