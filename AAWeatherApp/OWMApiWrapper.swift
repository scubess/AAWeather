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
    private let decoder = JSONDecoder()
    private var locationName = ""
    
    // MARK: accessors
    var currentWeather = CurrentWeather.emptyInit() {
        willSet {
            objectWillChange.send()
        }
    }
    
    var forecastWeather : [ForecastWeatherList] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    var currentDescription = "" {
        willSet {
            objectWillChange.send()
        }
    }
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
    func getCurrentWeatherRequest(completion: @escaping OWMCurrentWeatherResponse) {
        let params : [String : String] = ["q": locationName, "units": OWMSettings.unit]
        self.performRequest(path: OWMSettings.weather, params: params) { (weather: CurrentWeather?, error) in
            completion(weather, error)
        }
    }
    
    func getForecastWeatherRequest(completion: @escaping OWMForecastWeatherResponse) {
        let params : [String : String] = ["q": locationName, "units": OWMSettings.unit]
        self.performRequest(path: OWMSettings.forecast, params: params) { (weather: ForecastWeather?, error) in
            completion(weather, error)
        }
    }
    
    // Make API request 
    public func performRequest<T: Codable>(path: String, params: [String:String], completion: @escaping (_ object: T?,_ error: Error?) -> ()) {
    
        // prepare url components
        var urlComponents = URLComponents(string: apiUrl + path)!
        
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "appid", value: apiKey)]
        for (name, value) in params {
          let item = URLQueryItem(name: name, value: value)
          queryItems.append(item)
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
          assertionFailure("Invalid url: \(urlComponents)")
          return
        }
        
        // prepare request
        let request = URLRequest(url: url)
        
        // make the call
        let configuration = URLSessionConfiguration.default
        let task =  URLSession(configuration: configuration).dataTask(with: request) { data, response, error in
          guard let data = data else {
            completion(nil, error)
            return
          }
          
          if data.count == 0 {
            completion(nil, nil)
            return
          }
        
          do {
                let weather = try self.decoder.decode(T.self, from: data)
                completion(weather, nil)
            } catch let error {
                debugPrint(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
        
    public func getCurrentWeatherData(completion: @escaping OWMCurrentWeatherResponse ) {
        self.getCurrentWeatherRequest { [weak self] currentWeather, error in
            guard let cw = self else { return }
            if let currentWeather = currentWeather {
                cw.currentWeather = currentWeather
                cw.currentDescription = currentWeather.description()
            }
            completion(currentWeather, nil)
        }
    }
    
    public func getForecastWeatherData(completion: @escaping OWMForecastWeatherResponse ) {
        self.getForecastWeatherRequest { [weak self] forecastWeather, error in
            guard let fw = self else { return }
            if let forecastWeather = forecastWeather {
                fw.forecastWeather = forecastWeather.dailyList
            }
            completion(forecastWeather, nil)
        }
    }
}
