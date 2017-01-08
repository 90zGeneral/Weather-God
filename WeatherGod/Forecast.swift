//
//  Forecast.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/7/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import Alamofire


//Represents the cell content
class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    //Getters
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        
        return _highTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        
        return _lowTemp
    }
    
    //Initialization of this class
    init(weatherDict: [String: Any]) {
        
        //Access the temp dictionary holding the min & max temp
        if let temp = weatherDict["temp"] as? [String: Any] {
            
            //Get the min temp
            if let min = temp["min"] as? Double {
                
                //Converting Kelvin to Farenheit
                let convertingKelvin = (min * (9 / 5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * convertingKelvin / 10))
                self._lowTemp = kelvinToFarenheit
                print("")
                print(self._lowTemp)
            }
            
            //Get the max temp
            if let max = temp["max"] as? Double {
                
                //Converting Kelvin to Farenheit
                let convertingKelvin = (max * (9 / 5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * convertingKelvin / 10))
                self._highTemp = kelvinToFarenheit
                print(_highTemp)
                
            }
            
        }
        
        //Access the weather array holding the weather type in a key called "main"
        if let weather = weatherDict["weather"] as? [[String: Any]] {
            
            //Get the weather type
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
                print(_weatherType)
            }
        }
        
        //Access the date represented as "dt" in the list array
        if let date = weatherDict["dt"] as? Double? {
            
            //The date is in a Unix standard that needs to be converted
            let unixConvertedDate = Date(timeIntervalSince1970: date!)
            
            //Assign the custom dayOfTheWeek method created in the Date extension to _date
            self._date = unixConvertedDate.dayOfTheWeek()
            print(_date)
        }
    }
    
}

//Extension on Apple's Date class formally known as NSDate
extension Date {
    
    //Find the day of the week
    func dayOfTheWeek() -> String {
        
        //A date formatter to determine its presentation
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full      //Get the full date including the day of the week
        dateFormatter.timeStyle = .none      //Omit the default timestamp
        
        //This is how the day of the week is represented
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}








