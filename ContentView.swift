//
//  ContentView.swift
//  WeatherApp
//
//  Created by AbdulHameed Mohamed on 17/05/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel(dataSource: WeatherDataSource())
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            weatherViewModel.getWeather()
        }
        .onReceive(weatherViewModel.$weatherData) { weatherData in
            if let weatherData = weatherData {
                print("Weather data observed in ContentView: \(weatherData)")
            }
        }
    }
}

#Preview {
    ContentView()
}
