//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 22.03.2024.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    private var locationManager: CLLocationManager = CLLocationManager()
    
    private(set) var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        locationManager.delegate = self
        checkLocationAuthorization()
    }

    let cityWeatherVC = CityWeatherViewController()
    let noUserVC = NoUserLocationViewController()
    func showCityWeatherVC() {
        self.addChildVC(cityWeatherVC, frame: view.frame)
        createNavBarHamburgerButton(with: nil)
        createNavBarTitle(for: "View")
        noUserVC.removeChildVC()
    }
    
    func showNoUserLocationPermissionVC() {
        self.addChildVC(noUserVC, frame: view.frame)
        navigationItem.titleView = nil
        navigationItem.leftBarButtonItem = nil
        cityWeatherVC.removeChildVC()
    }

    
    private func checkLocationAuthorization() {
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("denied")
            
            showNoUserLocationPermissionVC()
        case .authorizedAlways, .authorizedWhenInUse:
            print("it's okay")
            
            locationManager.startUpdatingLocation()
            showCityWeatherVC()
        @unknown default:
            break
        }
        
        
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("here")
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            currentLocation = location.coordinate
        }
    }
}
