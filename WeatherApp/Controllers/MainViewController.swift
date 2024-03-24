//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 22.03.2024.
//

import UIKit

class MainViewController: UIViewController {
   
    private let locationManager: LocationManagerWithCompletionBlockProtocol
    private let apiManager: ApiManager
    
    private let cityWeatherChildVC: CityWeatherViewController
    
    //MARK: Initializers
    init(locationManager: LocationManagerWithCompletionBlockProtocol, apiManager: ApiManager){
        self.locationManager = locationManager
        self.apiManager = apiManager
        cityWeatherChildVC = CityWeatherViewController(apiManager: self.apiManager)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Life cycle hooks
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.addChildVC(cityWeatherChildVC, frame: view.frame)
        createNavBarHamburgerButton(withAction: nil)
        
        locationManager.locationChangeCompletion = {[weak self] isDenyAccess in
            guard let self else {return}
            DispatchQueue.main.async{
                if !isDenyAccess{
                    let location = self.locationManager.currentLocation ?? Coordinates.londonCoordinates.toCLLocation()
                    self.setCityNameToNavBarTitle(by: location)
                    self.cityWeatherChildVC.showLocation(
                        location: Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    )
                } else {
                    self.setCityNameToNavBarTitle(by: Coordinates.londonCoordinates.toCLLocation())
                    self.cityWeatherChildVC.showLocation(location: Coordinates.londonCoordinates)
                }
            }
        }
        locationManager.checkLocationAuthorization()
    }

}
