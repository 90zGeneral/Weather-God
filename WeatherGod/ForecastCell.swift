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
        forecastImage.image = UIImage(named: forecast.weatherType)
    }

}
