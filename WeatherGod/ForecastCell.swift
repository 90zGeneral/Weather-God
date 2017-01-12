//
//  ForecastCell.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/8/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastDay: UILabel!
    @IBOutlet weak var forecastType: UILabel!
    @IBOutlet weak var forecastHigh: UILabel!
    @IBOutlet weak var forecastLow: UILabel!
    
    
    //Pass data from the Forecast class to update the cell
    func configureCell(forecast: Forecast) {
        forecastLow.text = "\(forecast.lowTemp)"
        forecastHigh.text = "\(forecast.highTemp)"
        forecastType.text = forecast.weatherType
        forecastDay.text = forecast.date
        
        //Set the forecast image for clear to be the original image for clear and not the mini
        if forecastType.text == "Clear" || forecastType.text == "Thunderstorm" {
            forecastImage.image = UIImage(named: forecast.weatherType)
            
        }else if forecastType.text == "Snow" || forecastType.text == "Partially Cloudy" {
            forecastImage.image = UIImage(named: forecast.weatherType)
            
        }else {
            forecastImage.image = UIImage(named: forecast.weatherType + " Mini")
        }
    }

}
