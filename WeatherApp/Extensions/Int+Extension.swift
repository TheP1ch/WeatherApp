//
//  Int+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//
import Foundation

extension Int{
    static func compassDirection(windDirection degree: Int) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]

        var index = Int(ceil(Double(degree) / 45 + 0.5))
        index = index % 8
        
        return directions[index]
    }
}
