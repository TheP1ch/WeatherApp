//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import Foundation

enum RequestError: Error{
    case invalidUrl
}

final class ApiManager{
    private let baseURL = "https://timemachine.pirateweather.net/forecast/"
    private let apiKey = "Uv8az01LGG2bKIR4ynl866fCCAlmC2vK"
    
    /// With this units parameter Wind Speed and Wind Gust will be in kilometres per hour.
    private let unitsParam = "ca"
    
    func obtainForecast(for coordinates: Coordinates) async throws {
//        URLSession.shared.data(for: <#T##URLRequest#>)
        let requestUrl = "\(baseURL)/\(apiKey)/\(coordinates.latitude)/\(coordinates.longitude)/?units=\(unitsParam)"
        guard let url = URL(string: requestUrl) else {
            throw RequestError.invalidUrl
        }
        
        
    }
}
