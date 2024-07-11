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
    
    var outputCurrentInfo = Observable<OpenWeatherResponse?>(nil)
    
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
}
