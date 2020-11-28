//
//  ViewController.swift
//  AAWeatherApp
//
//  Created by Lshiva on 28/11/2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Temperature: UILabel!
    @IBOutlet weak var MaxTemperature: UILabel!
    
    @IBOutlet weak var MinTemperature: UILabel!
    @IBOutlet var tableView: UITableView!
    let cellReuseIdentifier = "cell"
    
    var owmApiWrapper : OWMApiWrapper!
    var forecastWeather : [ForecastWeatherList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        owmApiWrapper = OWMApiWrapper(apiUrl: OWMSettings.apiUrl, apiKey: OWMSettings.apiKey)
        owmApiWrapper.setLocation(name: "London,uk")
        print("Open Weather Map version: \(owmApiWrapper.api_wrapper_version)")
        
        owmApiWrapper.getCurrentWeatherData { (weather, error) in
            self.loadCurrentWeather()
        }

        owmApiWrapper.getForecastWeatherRequest {  (weather, error) in
            DispatchQueue.main.async {
                self.forecastWeather = weather?.dailyList
                self.loadForecastWeather()
            }
        }
    }
    
    func loadCurrentWeather() {
        DispatchQueue.main.async {
            self.Location.text = self.owmApiWrapper.currentWeather.name
            self.Description.text = self.owmApiWrapper.currentWeather.description()
            self.Temperature.text = self.owmApiWrapper.currentWeather.mainValue.temperature()
            self.MaxTemperature.text = self.owmApiWrapper.currentWeather.mainValue.maxTemperature()
            self.MinTemperature.text = self.owmApiWrapper.currentWeather.mainValue.minTemperature()
        }
    }
    
    func loadForecastWeather() {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.forecastWeather != nil {
            return self.forecastWeather!.count
        }
        return 0
    }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
    var forecast = self.forecastWeather![indexPath.row].dayWord()
        forecast += " "
        forecast += self.forecastWeather![indexPath.row].mainValue.minTemperature()
        forecast += " "
        forecast += self.forecastWeather![indexPath.row].mainValue.maxTemperature()
        cell.textLabel?.text = forecast
        return cell
    }
}

