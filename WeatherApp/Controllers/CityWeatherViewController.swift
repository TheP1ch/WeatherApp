//
//  CityWeatherViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import UIKit
import CoreLocation

protocol ReloadDataProtocol{
    func reloadData() -> ()
}

class CityWeatherViewController: UIViewController {
    
    private var cityCoordinates: Coordinates = Coordinates.londonCoordinates
    
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
//        view.backgroundColor = UIColor(r: 173, g: 216, b: 230, a: 0.8)
        configurePrimaryView()
    }
    
    func showForecast(for location: Coordinates){
        self.showLoadingView()
        Task{
            do{
                cityCoordinates = location
                let weatherForecast = try await apiManager.obtainWeatherForecast(for: location)
                self.primaryView.configure(weatherForecastData: [
                    .current(weatherForecast.currently),
                    .hourly(weatherForecast.hourly.data),
                    .daily(weatherForecast.daily.data)
                ])
                self.dismissLoadingView()
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
            primaryView.topAnchor.constraint(equalTo: view.topAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            primaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}

extension CityWeatherViewController: ReloadDataProtocol{
    func reloadData() {
        self.showForecast(for: cityCoordinates)
    }
}
