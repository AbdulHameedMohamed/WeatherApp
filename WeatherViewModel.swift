//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    
    let dataSource: DataSource
        
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func getWeather(location: String) {
        let parameters: [String: Any] = [
            "key": ApiURLs.API_KEY.rawValue,
            "q": location,
            "days": 3,
            "aqi": "no",
            "alerts": "no"
        ]

        dataSource.makeCallToApi(url: ApiURLs.BASE_URL.rawValue, params: parameters) { (weatherData: WeatherData?, error: Error?) in
            if let error = error {
                print("Error fetching weather data: \(error)")
            } else {
                self.weatherData = weatherData
            }
        }
    }
}
