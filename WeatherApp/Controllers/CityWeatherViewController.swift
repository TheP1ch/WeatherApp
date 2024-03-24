//
//  CityWeatherViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import UIKit
import CoreLocation

class CityWeatherViewController: UIViewController {
    
    //MARK: View Elements
    private let primaryView: CurrentWeatherView = CurrentWeatherView()
    
    //MARK: Dependencies
    private let apiManager: ApiManager
    
    //MARK: Initializers
    init(apiManager: ApiManager){
        self.apiManager = apiManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Life cycle hooks
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePrimaryView()
    }
    
    func showLocation(location: Coordinates){
        Task{
            do{
                let weatherForecast = try await apiManager.obtainWeatherForecast(for: location)
                self.primaryView.configure(weatherForecast: weatherForecast)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: View configuration methods
    private func configurePrimaryView() {
        view.addSubview(primaryView)
        
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            primaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}
