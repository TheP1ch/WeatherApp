//
//  File.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import Foundation

struct CurrentForecast: Codable{
    let time: Int
    let summary: String
    let icon: String
    let humidity: Double
    let pressure: Double
    let temperature: Double
    let apparentTemperature: Double
    let windSpeed: Double
}

struct DailyForecast: Codable{
    let time: Int
    let summary: String
    let icon: String
    let humidity: Double
    let pressure: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let windSpeed: Double
}

struct HourlyForecast: Codable{
    let data: [CurrentForecast]
}

struct WeekForecast: Codable{
    let data: [DailyForecast]
}

struct WeatherForecast: Codable {
    let currently: CurrentForecast
    let hourly: HourlyForecast
    let daily: WeekForecast
}



