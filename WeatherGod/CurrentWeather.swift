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
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        //Tell Alamofire where to download from
        let weatherURL = URL(string: currentWeatherURL)!
        
        //Alamofire GET Request
        Alamofire.request(weatherURL).responseJSON { (response) in
            
            //Grabbing the value from the response result
            let result = response.result.value
            
            //Cast the json object as a Swift Dictionary for usability
            if let dict = result as? [String: Any] {
                
                //To get the city name
                if let city = dict["name"] as? String {
                    self._cityName = city.capitalized
                    print(self._cityName)
                }
                
                //To get the weather type
                if let weatherArr = dict["weather"] as? [[String: Any]] {
                    if let main = weatherArr[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                //to get the current temperature
                if let dictMain = dict["main"] as? [String: Any] {
                    if let temp = dictMain["temp"] as? Double {
                        
                        //Convert the temperature from Kelvin measurement system to Farenheit
                        let convertingKelvin = (temp * (9 / 5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * convertingKelvin / 10))
                        self._currentTemp = kelvinToFarenheit
                        print(self._currentTemp)
                    }
                }
            }
            //Tell it to complete
            completed()
        }
    }
    
}
