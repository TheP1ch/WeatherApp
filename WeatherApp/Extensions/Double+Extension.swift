//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import Foundation

extension Double{
    func toIntUp() -> Int{
        return Int(ceil(self))
    }
    
    func toCompassDirection() -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]

        var index = Int(ceil(self) / 45 + 0.5)
        index = index % 8
        
        return directions[index]
    }
}
