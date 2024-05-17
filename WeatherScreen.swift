//
//  ContentView.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import SwiftUI
import Kingfisher

struct WeatherScreen: View {
    @StateObject private var weatherViewModel = WeatherViewModel(dataSource: WeatherDataSource())
    
    var body: some View {
        Group {
            if let weatherData = weatherViewModel.weatherData {
                ZStack {
                    getBackground(for: weatherData).ignoresSafeArea()
                    ContentView(weatherData: weatherData)
                }
            } else {
                ProgressView("Fetching Weather...")
            }
        }
        .onAppear {
            weatherViewModel.getWeather()
        }
    }
    
    private func getBackground(for weatherData: WeatherData) -> some View {
        let isDaytime = isDaytimeNow(weatherData: weatherData)
        
        if isDaytime {
            return Image("Day")
                .resizable()
                .scaledToFill()
        } else {
            return Image("Night")
                .resizable()
                .scaledToFill()
        }
    }
    
    private func isDaytimeNow(weatherData: WeatherData) -> Bool {
        return weatherData.current.condition.text.lowercased() == "sunny"
    }
}

struct ContentView: View {
    let weatherData: WeatherData
    
    var body: some View {
        VStack(spacing: 10) {
            TopSection(weatherData: weatherData)
            MidSection(forecastData: weatherData.forecast.forecastday)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .onAppear {
            print(weatherData.forecast.forecastday)
        }
    }
}

struct TopSection: View {
    let weatherData: WeatherData
    
    var body: some View {
        VStack(spacing: 10) {
            Text(weatherData.location.name)
                .font(.largeTitle)
            Text("\(Int(weatherData.current.temp_c))°C")
                .font(.title)
            Text(weatherData.current.condition.text)
                .font(.headline)
            HStack {
                Text("High: \(Int(weatherData.forecast.forecastday[0].day.maxtemp_c))°C")
                    .font(.subheadline)
                Text("Low: \(Int(weatherData.forecast.forecastday[0].day.mintemp_c))°C")
                    .font(.subheadline)
            }
            let iconURLString = "https:" + weatherData.current.condition.icon
            if let iconURL = URL(string: iconURLString) {
                KFImage(iconURL)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
        .padding()
        .offset(y: 125)
    }
}

struct MidSection: View {
    let forecastData: [Forecastday]
    
    var body: some View {
        List {
            ForEach(forecastData) { forecast in
                HStack(spacing: 5) {
                    Text(getDayName(from: forecast.date))
                        .font(.headline)
                    if let iconURL = URL(string: "https:" + forecast.day.condition.icon) {
                        KFImage(iconURL)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                    Text("High: \(Int(forecast.day.maxtemp_c))°C  Low: \(Int(forecast.day.mintemp_c))°C")
                        .font(.subheadline)
                }
                .padding()
                .background(Color.white.opacity(0))
                .cornerRadius(10)
                .shadow(radius: 3)
            }
            .listRowBackground(Color.white.opacity(0))
        }
        .offset(y: 75)
        .navigationTitle("3-Day Forcast")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(PlainListStyle())
        .background(Color.white.opacity(0))
        .padding()
    }
    
    func getDayName(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        return dayFormatter.string(from: date)
    }
}
#Preview {
    WeatherScreen()
}
