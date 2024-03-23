//
//  File.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import Foundation

struct DailyForecast: Codable{
    let time: Int
    let summary: String
    let icon: String
    let humidity: Double
    let pressure: Double
    let temperature: Double
    let apparentTemperature: Double
    let windSpeed: Double
}

struct WeatherForecast: Codable {
    let currently: DailyForecast
    let daily: [DailyForecast]
}

//struct CurrentlyWeather: Codable{
//
//}


