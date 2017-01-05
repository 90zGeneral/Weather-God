//
//  CurrentWeather.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/5/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    //Getters
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()   //Create an empty constant of type DateFormatter
        dateFormatter.dateStyle = .medium     //Give the dateFormatter a medium style date
        dateFormatter.timeStyle = .none       //Omit the default time
        
        //Make the date string adhere to the date style created above and assign it to _date
        let currentDate = dateFormatter.string(from: Date())
        _date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    
    
    //Download the data. The type for the completed parameter comes from the typealias in the Constants.swift file
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        //Tell Alamofire where to download from
        let weatherURL = URL(string: currentWeatherURL)!
        
        //Alamofire GET Request
        Alamofire.request(weatherURL).responseJSON { (response) in
            let result = response.result.value!
            print(result)
        }
        //Tell it to complete
        completed()
    }
    
}
