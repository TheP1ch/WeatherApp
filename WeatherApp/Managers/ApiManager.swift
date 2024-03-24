//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import Foundation

enum RequestError: Error{
    case invalidUrl
    case unexpectedResponse
    case failedResponse
}

final class ApiManager{
    //MARK: Const variables for requestUrl
    private let baseURL = "https://api.pirateweather.net/forecast"
    private let apiKey = "Uv8az01LGG2bKIR4ynl866fCCAlmC2vK"
    
    /// With this units parameter Wind Speed and Wind Gust will be in kilometres per hour.
    private let unitsParam = "ca"
    
    private static let httpStatusCodeSuccess = 200..<300
    
    private lazy var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return jsonDecoder
    }()
    
    //MARK: HTTP Methods
    func obtainWeatherForecast(for coordinates: Coordinates) async throws -> WeatherForecast {
        let requestUrl = "\(baseURL)/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)?units=\(unitsParam)"
        guard let url = URL(string: requestUrl) else {
            throw RequestError.invalidUrl
        }
        
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else{
            throw RequestError.unexpectedResponse
        }
        
        guard Self.httpStatusCodeSuccess.contains(response.statusCode) else {
            throw RequestError.failedResponse
        }
        return try jsonDecoder.decode(WeatherForecast.self, from: data)
    }
}
