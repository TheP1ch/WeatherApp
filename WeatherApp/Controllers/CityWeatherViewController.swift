//
//  CityWeatherViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import UIKit
import CoreLocation

class CityWeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createNavBarHamburgerButton(withAction: nil)
//        createNavBarTitle(for: "View")
//        geoCode()
    }
    
    func showLocation(location: Coordinates){
//        geoCode(location: location)
        print("City weather", location)
    }

}
