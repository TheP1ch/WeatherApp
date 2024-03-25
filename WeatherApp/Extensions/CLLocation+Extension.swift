//
//  CLLocation+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 25.03.2024.
//

import CoreLocation

extension CLLocation{
    func compareByTown(with location: CLLocation?) async throws -> Bool{
        guard let location = location else {return false}
        let geoCoder = CLGeocoder()
        let newLocationPlacemarks = try await geoCoder.reverseGeocodeLocation(location)
        let oldLocationPlacemarks = try await geoCoder.reverseGeocodeLocation(self)
        
        guard let newPlacemark = newLocationPlacemarks.first, let oldPlacemark = oldLocationPlacemarks.first else {return false}
        
        return newPlacemark.locality == oldPlacemark.locality
    }
}
