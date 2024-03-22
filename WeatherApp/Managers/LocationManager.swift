//
//  CLLocationManager.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 22.03.2024.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol{
    var currentLocation: CLLocationCoordinate2D? {get}
    func checkLocationAuthorization() -> Bool
}

final class LocationManager: NSObject, LocationManagerProtocol {
    
    //MARK: Variables
    private var locationManager: CLLocationManager = CLLocationManager()
    
    private(set) var currentLocation: CLLocationCoordinate2D?
    
    
    
    //MARK: Methods
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    @discardableResult func checkLocationAuthorization() -> Bool {
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("it's okay")
            locationManager.startUpdatingLocation()
            return true
        @unknown default:
            break
        }
        
        return false
    }

}

extension LocationManager: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            currentLocation = location.coordinate
        }
    }
}
