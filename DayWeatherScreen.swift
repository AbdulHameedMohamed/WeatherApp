//
//  DayWeatherScreen.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import SwiftUI

struct DayWeatherScreen: View {
    let dayWeatherData: Forecastday
    
    var body: some View {
        VStack {
            Text("Weather details for \(dayWeatherData.date)")
            Text("High: \(Int(dayWeatherData.day.maxtemp_c))°C")
            Text("Low: \(Int(dayWeatherData.day.mintemp_c))°C")
            // Add more weather details as needed
        }
        .padding()
    }
}

struct DayWeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        let sampleForecastDay = Forecastday(
            date: "2024-05-17",
            date_epoch: 1621227600,
            day: Day(
                maxtemp_c: 25.0,
                maxtemp_f: 77.0,
                mintemp_c: 15.0,
                mintemp_f: 59.0,
                avgtemp_c: 20.0,
                avgtemp_f: 68.0,
                maxwind_mph: 10.0,
                maxwind_kph: 16.1,
                totalprecip_mm: 0.0,
                totalprecip_in: 0.0,
                totalsnow_cm: 0.0,
                avgvis_km: 10.0,
                avgvis_miles: 6.0,
                avghumidity: 50,
                condition: Condition(text: "Partly cloudy", icon: "https://www.weather.com/images/icon-partly-cloudy.svg", code: 1003)
            ),
            astro: Astro(
                sunrise: "05:30 AM",
                sunset: "07:30 PM",
                moonrise: "11:00 AM",
                moonset: "01:00 AM",
                moon_phase: "First Quarter",
                moon_illumination: 50,
                is_moon_up: 1,
                is_sun_up: 1
            ),
            hour: []
        )
        
        return DayWeatherScreen(dayWeatherData: sampleForecastDay)
    }
}
