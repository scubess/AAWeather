//
//  ViewController.swift
//  AAWeatherApp
//
//  Created by Lshiva on 28/11/2020.
//

import UIKit

class ViewController: UIViewController {

    var owmApiWrapper : OWMApiWrapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        owmApiWrapper = OWMApiWrapper(apiUrl: OWMSettings.apiUrl, apiKey: OWMSettings.apiKey)
        
    }


}

