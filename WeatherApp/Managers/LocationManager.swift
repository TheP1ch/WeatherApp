//
//  File.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol{
    func checkLocationAuthorization() -> ()
    var currentLocation: CLLocation? {get}
}

protocol LocationManagerWithCompletionBlockProtocol: LocationManagerProtocol, AnyObject{
    var locationChangeCompletion: ((Bool) -> ()) { get set }
}

final class LocationManager: NSObject, LocationManagerWithCompletionBlockProtocol{
    private var locationManager: CLLocationManager = CLLocationManager()
    
    private(set) var currentLocation: CLLocation?
    
    var locationChangeCompletion: ((Bool) -> ()) = {_ in}
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            locationChangeCompletion(true)
        case .authorizedAlways, .authorizedWhenInUse:
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
//        print("\nsetLocation")
        if let location = locations.first {
            currentLocation = location
            locationChangeCompletion(false)
//            print("wasSet", location)
        }
    }
}
