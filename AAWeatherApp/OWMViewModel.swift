//
//  OWMDataTypes.swift
//  AAWeatherApp
//
//  Created by Lshiva on 28/11/2020.
//

import Foundation

struct CurrentWeather : Codable {
    var date: Int
    var timezone : Int
    var name : String
    let mainValue: WeatherMainValue
    let elements : [WeatherElements]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case mainValue = "main"
        case elements = "weather"
        case timezone
        case name
    }
        
    func description() -> String {
        var result = ""
        if let weatherElement = elements.first {
            result += "\(weatherElement.weatherDescription.capitalized)"
        }
        return result
    }
        
    static func emptyInit() -> CurrentWeather {
        return CurrentWeather(
            date: 0,
            timezone: 0,
            name: "",
            mainValue: WeatherMainValue.emptyInit(),
            elements: []
        )
    }
}

struct ForecastWeather : Codable {
    let code: String
    let message, count: Int
    let list: [ForecastWeatherList]
    let city: WeatherCity
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case list, city
    }

    var dailyList: [ForecastWeatherList] {
        var result: [ForecastWeatherList] = []
        guard var before = list.first else {
            return result
        }
        
        if before.date.dateFromMilliseconds().dayWord() != Date().dayWord() {
            result.append(before)
        }

        for weather in list {
            if weather.date.dateFromMilliseconds().dayWord() != before.date.dateFromMilliseconds().dayWord() {
                result.append(weather)
            }
            before = weather
        }

        return result
    }
    static func emptyInit() -> ForecastWeather {
        return ForecastWeather(
            code: "",
            message: 0,
            count: 0,
            list: [],
            city: WeatherCity.emptyInit()
        )
    }
}

struct ForecastWeatherList: Codable {
    var date: Int
    var mainValue: WeatherMainValue
    var elements: [WeatherElements]

    enum CodingKeys: String, CodingKey {
        case mainValue = "main"
        case date = "dt"
        case elements = "weather"
    }
    
    func dayWord() -> String {
        return String(date.dateFromMilliseconds().dayWord())
    }
    
    static func emptyInit() -> ForecastWeatherList {
        return ForecastWeatherList(
            date: 0,
            mainValue: WeatherMainValue.emptyInit(),
            elements: []
        )
    }
}

struct WeatherMainValue : Codable {
    public var temp : Double
    public var tempMin : Double
    public var tempMax : Double
    
    enum CodingKeys : String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
     func temperature() -> String {
        return "\(String(Int(temp)))"
    }

    func maxTemperature() -> String {
        return "H:\(String(Int(tempMax)))"
    }

    func minTemperature() -> String {
        return "L:\(String(Int(tempMin)))"
    }
    
    static func emptyInit() -> WeatherMainValue {
        return WeatherMainValue(
            temp: 0.0,
            tempMin: 0,
            tempMax: 0
        )
    }
}

struct WeatherElements: Codable {
    let id: Int
    let main : String
    let weatherDescription : String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    static func emptyInit() -> WeatherElements {
        return WeatherElements(
            id: 0,
            main: "",
            weatherDescription: "",
            icon: ""
        )
    }
}

struct  WeatherCity : Codable {
    let id : Int
    let name : String
    let country : String
    let timezone : Int
    
    static func emptyInit() -> WeatherCity {
        return WeatherCity(
            id: 0,
            name: "",
            country: "",
            timezone: 0
        )
    }
}
