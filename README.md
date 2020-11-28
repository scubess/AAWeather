# AAWeather

An app to use open Street map API to display weather forecast for 5 days for selected location


## Get started 

* A valid API key from Openweathermap
* A Mac running macOS Catalina
* Xcode 11.3+
* Swift 4.1+

## Installation

* Clone or download the project to your local machine
* Open the project in Xcode
* Replace <your api key> with your valid Openweathermap API key in config.swift

```swift		
    static let apiKey       = "<your API Key Here>"
```

* set location to open street map predefined location list in `ViewController.swift`, which can be downloaded as JSON from open street map [website](http://bulk.openweathermap.org/sample/)

```swift		        
	owmApiWrapper.setLocation(name: "London,uk")        
```     

# Usage

you can manually drag OWMApiWrapper folder into your own project. Use the following code with in your project with OWM API key to initialize the wrapper:

```swift	
	owmApiWrapper = OWMApiWrapper(apiUrl: OWMSettings.apiUrl, apiKey: OWMSettings.apiKey)
```

Each call takes completion block as the last parameter. This allows swift's trailing closure syntax to be used. The closure parameters contains the results. If there is any problem with any call, it will be indicated by the `error` object. 


## Current Weather 

To get current weather data from the API response, please use

```swift
   // get current weather
	owmApiWrapper.getCurrentWeatherData { (weather, error) in

	}
```

## Forecast Weather 
To get current weather data from the API response, please use

```swift
	// get forecast weather
	owmApiWrapper.getForecastWeatherData {  (weather, error) i

	}
```

## Features 
* Portable open Weather map API wrapper 
* using Swift 4.1+ JSON & Decodable, ObservableObject 
* Generics to load data
* OpenWeather Map API Wrapper is fully extendable

## Fixes 
* Very minimal UI to present Data 
* Not all JSON keys are accessible 
* Image is not Utilised
* The wrapper can be spilit into network, datatypes and model strucuture. More MVVM approach. Especially `OWMViewModel.swift` file
* The whole UI experience can be done with third party tools like snapkit etc,.


## technical Debt 

* If the time is not a problem, the API wrapper can be accessed via swift package manager. Also accessible via cocoapods or carthage. There is a high chance to track bugs, fixes in the Wrapper. Also useful to lay roadmap for improvements. 
