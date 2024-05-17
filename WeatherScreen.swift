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
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
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

#Preview {
    WeatherScreen()
}
