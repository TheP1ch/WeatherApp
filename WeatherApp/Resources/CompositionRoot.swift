//
//  CompositionRoot.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 22.03.2024.
//

import UIKit



/// Class for dependency injection
final class CompositionRoot{
    let navigationController: UINavigationController = UINavigationController(rootViewController: MainViewController())
    lazy var locationManager: LocationManagerProtocol = {
        let lM = LocationManager(showNoUserLocationVC: self.showNoUserLocactionVC, showUserCityWeatherVC: self.showUserCityWeatherVC)
        
        return lM
    }()
    
    func showNoUserLocactionVC() {
        self.navigationController.setViewControllers([NoUserLocationViewController()], animated: true)
    }
    
    func showUserCityWeatherVC() {
        self.navigationController.setViewControllers([ViewController(locationManager: self.locationManager)], animated: true)
    }
    
}
