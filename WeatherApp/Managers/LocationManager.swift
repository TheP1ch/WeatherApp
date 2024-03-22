//
//  CLLocationManager.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 22.03.2024.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol{
    func checkIfLocationServicesIsEnabled() -> ()
}

final class LocationManager: NSObject, LocationManagerProtocol {
    private var locationManager: CLLocationManager = CLLocationManager()
    
    
    
    func checkIfLocationServicesIsEnabled() {
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.checkLocationAuthorization()
            }else {
                print("allow location")
            }
        }
    }
    
    private func checkLocationAuthorization() {
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted")
        case .denied:
            print("you have denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("you have")
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }

}

extension LocationManager: CLLocationManagerDelegate{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("delegasion")
        if locations.first != nil {
            print(locations)
        }
    }
}
