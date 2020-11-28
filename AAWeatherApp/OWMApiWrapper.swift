//
//  OWMApiWrapper.swift
//  AAWeatherApp
//
//  Created by Lshiva on 28/11/2020.
//

import Foundation

enum ResponseError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidURL
}

typealias OWMCurrentWeatherResponse = (CurrentWeather?, Error?) -> Void
typealias OWMForecastWeatherResponse = (ForecastWeather?, Error?) -> Void


class OWMApiWrapper: ObservableObject {
    public let api_wrapper_version = "1.0.0"
    var apiUrl  :String
    var apiKey  : String
    private let decoder = JSONEncoder()
    private var locationName = ""
    
    // MARK: Constructors
    public init(apiUrl: String, apiKey:String) {
        self.apiUrl = apiUrl
        self.apiKey = apiKey
    }
    
    // set location
    public func setLocation(name: String) {
        self.locationName = name
    }
    
    // MARK: API Convert Functions
    // get current weather
    func getCurrentWeatherRequest() {
        
    }
    
    // get forecast weather
    func getForecastWeatherRequest() {
        
    }
    
    // Make API request 
    public func performRequest() {
    
    }
    
}
