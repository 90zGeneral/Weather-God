//
//  DetailsVC.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/13/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    //Declare a new instance of CurrentWeather
    var currentWeather: CurrentWeather!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Instantiate the new instance
        currentWeather = CurrentWeather()
        
        currentWeather.downloadWeatherDetails {
            //Function call
            self.updateUI()
        }
    }
    
    //Update the view
    func updateUI() {
        
        sunrise.text = currentWeather.sunrise + " EST"
        sunset.text = currentWeather.sunset + " EST"
        weatherDescription.text = currentWeather.weatherDescription
        humidity.text = "\(currentWeather.humidity)%"
        windSpeed.text = "\(Int(round(currentWeather.windSpeed))) mph"
        
        //Let the Nav bar display the current city
        navBar.topItem?.title = currentWeather.cityName.capitalized
        
        
    }

}
