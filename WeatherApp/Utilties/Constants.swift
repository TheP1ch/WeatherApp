//
//  Consts.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import Foundation

enum WeatherIcon: String{
    case fog = "cloud.fog.fill"
    case clearDay = "sun.max.fill"
    case clearNight = "moon.stars"
    case rain = "cloud.rain.fill"
    case snow = "snowflake"
    case sleet = "cloud.sleet.fill"
    case wind = "wind"
    case cloudy = "cloud.fill"
    case partlyCloudyDay = "cloud.sun.fill"
    case partlyCloudyNight = "cloud.moon.fill"
}

let IconApiDictionary: [String : WeatherIcon] = [
    "clear-day": .clearDay,
    "clear-night": .clearNight,
    "rain": .rain,
    "snow": .snow,
    "sleet": .sleet,
    "wind": .wind,
    "fog": .fog,
    "cloudy": .cloudy,
    "partly-cloudy-day": .partlyCloudyDay,
    "partly-cloudy-night": .partlyCloudyNight
]


