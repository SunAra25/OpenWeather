//
//  City.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

struct City: Decodable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coord
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}
