//
//  MainViewModel.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import Foundation
import Alamofire

class MainViewModel {
    var inputViewAppear = Observable<Void?>(nil)
    var inputListBtnTap = Observable<Void?>(nil)
    
    var outputCurrentInfo = Observable<OpenWeatherResponse?>(nil)
    var outputTimeForecastList = Observable<[List]>([])
    var outputDayForecastList = Observable<[DayForecast]>([])
    var outputPushSearchVC = Observable<String?>(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewAppear.bind { [weak self] _ in
            guard let self else { return }
            fetchCurrentWeather { [weak self] data in
                guard let self else { return }
                outputCurrentInfo.value = data
            }
            fetchForecast { [weak self] data in
                guard let self else { return }
                
                outputTimeForecastList.value = filterTimeForecast(data)
                outputDayForecastList.value = filterDayForecast(data)
            }
        }
        
        inputListBtnTap.bind { [weak self] _ in
            guard let self else { return }
            outputPushSearchVC.value = outputCurrentInfo.value?.name
        }
    }
}

extension MainViewModel {
    func fetchCurrentWeather(completionHandler: @escaping (OpenWeatherResponse?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let appId = Bundle.main.object(forInfoDictionaryKey: "AppID") as? String ?? ""
        let parameters: Parameters = [
            "lat" : UserDefaultManager.shared.lastSearchCityLatitude,
            "lon" : UserDefaultManager.shared.lastSearchCityLongitude,
            "appid" : appId
        ]
        
        AF.request(
            url,
            parameters: parameters).responseDecodable(of: OpenWeatherResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    completionHandler(nil)
                    print(error)
                }
            }
    }
    
    func fetchForecast(completionHandler: @escaping (ForecastResponse?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/forecast"
        let appId = Bundle.main.object(forInfoDictionaryKey: "AppID") as? String ?? ""
        let parameters: Parameters = [
            "lat" : UserDefaultManager.shared.lastSearchCityLatitude,
            "lon" : UserDefaultManager.shared.lastSearchCityLongitude,
            "appid" : appId
        ]
        
        AF.request(
            url,
            parameters: parameters).responseDecodable(of: ForecastResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    completionHandler(nil)
                    print(error)
                }
            }
    }
    
    func filterTimeForecast(_ response: ForecastResponse?) -> [List] {
        guard let response else { return [] }
        let list = response.list
        let filterList = list.filter { $0.dtTxt.toDate()?.toString() == Date().toString() }
        
        if filterList.count < 5 {
            return Array(list.prefix(upTo: 5))
        } else {
            return Array(filterList)
        }
    }
    
    func filterDayForecast(_ response: ForecastResponse?) -> [DayForecast] {
        guard let response else { return [] }
        let list = response.list
        var forecast5Days: [[List]] = [list.filter { $0.dtTxt.toDate()?.toString() == Date().toString() } ]
        var result: [DayForecast] = []
        
        for n in 1...4 {
            forecast5Days.append( list.filter { $0.dtTxt.toDate()?.toString() == Date().afterNdays(n)?.toString() } )
        }
        
        forecast5Days.forEach { list in
            let tempList = list.map { $0.main.temp }
            
            guard let min = tempList.min(), let max = tempList.max() else { return }
            guard let minList = list.filter({ $0.main.temp == min }).first,
                  let maxList = list.filter({ $0.main.temp == max }).first,
                  let minDate = minList.dtTxt.toDate(),
                  let maxDate = maxList.dtTxt.toDate() else { return }
            let forecast = DayForecast(weekend: minDate.toString() == Date().toString() ? "오늘" : minDate.weekend(), icon: minList.weather.first?.icon, minTemp: min, maxTemp: max)
            
            result.append(forecast)
        }
        
        return result
    }
}
