//
//  SearchViewModel.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation

class SearchViewModel {
    var inputViewAppear = Observable<Void?>(nil)
    var inputSelectedCity = Observable<Int?>(nil)
    
    var outputCityList = Observable<[City]>([])
    var outputPopToPrevious = Observable<City?>(nil)
    
    init() {
        inputViewAppear.bind { [weak self] _ in
            guard let self else { return }
            outputCityList.value = fetchCityData()
        }
        
        inputSelectedCity.bind { [weak self] index in
            guard let self, let index else { return }
            outputPopToPrevious.value = outputCityList.value[index]
        }
    }
    
    func fetchCityData() -> [City] {
        guard let path = Bundle.main.path(forResource: "CityList", ofType: "json") else { return [] }
        guard let jsonString = try? String(contentsOfFile: path) else { return [] }
        
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data, let cityList = try? decoder.decode([City].self, from: data) {
            return cityList
        }
        
        return []
    }
}
