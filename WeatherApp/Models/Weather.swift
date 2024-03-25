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
    let windBearing: Double
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
    let windBearing: Double
}

struct HourlyWeather: Codable {
    let time: Int
    let icon: String
    let temperature: Double
}

struct DayForecastByHour: Codable{
    let data: [HourlyWeather]
}

struct WeekForecast: Codable{
    let data: [DailyForecast]
}

struct WeatherForecast: Codable {
    let currently: CurrentForecast
    let hourly: DayForecastByHour
    let daily: WeekForecast
}

enum WeatherForecastDataSourceModel {
    case current(CurrentForecast)
    case hourly([HourlyWeather])
    case daily([DailyForecast])
}

