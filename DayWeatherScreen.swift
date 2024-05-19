//
//  DayWeatherScreen.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import SwiftUI
import Kingfisher

struct DayWeatherScreen: View {
    let dayWeatherData: Forecastday

    var body: some View {
        Group {
            ZStack {
                if isMorningTime {
                    Image("Day")
                        .resizable()
                        .scaledToFill()
                } else {
                    Image("Night")
                        .resizable()
                        .scaledToFill()
                }
                DayContentView(dayWeatherData: dayWeatherData)
            }
        }
    }
}

struct DayContentView: View {
    let dayWeatherData: Forecastday

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(Array(hoursOfDay().enumerated()), id: \.1.id) { index, hour in
                    HourRow(hour: hour, isFirstHour: index == 0)
                }
            }
            .padding()
            .background(Color.white.opacity(0))
        }
    }
    
    private func hoursOfDay() -> [Hour] {
        let calendar = Calendar.current
        let now = Date()
        
        let currentHour = calendar.component(.hour, from: now)
        
        return dayWeatherData.hour.filter { hour in
            let hourOfDay = calendar.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(hour.time_epoch)))
            return hourOfDay >= currentHour
        }
    }
}

struct HourRow: View {
    let hour: Hour
    var isFirstHour: Bool
    
    init(hour: Hour, isFirstHour: Bool) {
        self.hour = hour
        self.isFirstHour = isFirstHour
    }
    
    var body: some View {
        HStack {
            if isFirstHour {
                Text("Now")
            } else {
                Text(formatTime(from: hour.time))
            }
            if let iconURL = URL(string: "https:" + hour.condition.icon) {
                KFImage(iconURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            Text("\(Int(hour.temp_c))°C")
        }
    }
    
    private func formatTime(from timeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
        guard let date = dateFormatter.date(from: timeString) else {
            return ""
        }
            
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "h:mm a"
        return dateFormatter2.string(from: date)
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
                condition: Condition(text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png", code: 1003)
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
