//
//  Config.swift
//  AAWeatherApp
//
//  Created by Lshiva on 28/11/2020.
//

import Foundation

public struct OWMSettings {
    static let apiVersion   = "2.5"
    static let apiUrl       = "https://api.openweathermap.org/data/\(apiVersion)"
    static let apiKey       = "<your API Key Here>"
    static let unit         = "metric"
    
    // endpoints
    static let weather     = "/weather"
    static let forecast    = "/forecast"    
}
