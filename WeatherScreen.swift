//
//  ContentView.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import SwiftUI

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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    WeatherScreen()
}
