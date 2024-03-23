//
//  Coordinates+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import CoreLocation

extension Coordinates {
    func toCLLocation() -> CLLocation{
        CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}
