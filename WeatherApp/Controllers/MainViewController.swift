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
//        view.backgroundColor = .whitex
        self.addChildVC(cityWeatherChildVC, frame: view.frame)
        createNavBarHamburgerButton(withAction: openSearchTownController)
        navigationItem.backButtonDisplayMode = .minimal
        
        locationManager.locationChangeCompletion = {[weak self] isDenyAccess in
            guard let self else {return}
            
            if !isDenyAccess{
                let location = self.locationManager.currentLocation ?? Coordinates.londonCoordinates.toCLLocation()
                self.setCityNameToNavBarTitle(by: location)
                self.cityWeatherChildVC.showForecast(
                    for: Coordinates(latitude: location.coordinate.latitude,
                                     longitude: location.coordinate.longitude)
                )
            } else {
                self.setCityNameToNavBarTitle(by: Coordinates.londonCoordinates.toCLLocation())
                self.cityWeatherChildVC.showForecast(for: Coordinates.londonCoordinates)
            }
        }
        locationManager.checkLocationAuthorization()
    }
    
    private lazy var openSearchTownController: UIAction = UIAction {[weak self] _ in
        guard let self else {return}
        
        let vc = SearchTownViewController(apiManager: apiManager)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
