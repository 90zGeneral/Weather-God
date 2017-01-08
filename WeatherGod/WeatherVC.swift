//
//  WeatherVC.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/3/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Declare new varaibles of type CurrentWeather & Forecast
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    
    //Array of Forecast
    var forecasts = [Forecast]()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        
        return cell
    }
    
    //Set a fixed height for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //To update the views
    func updateUI() {
        dateLbl.text = currentWeather.date
        cityLbl.text = currentWeather.cityName
        weatherTypeLbl.text = currentWeather.weatherType
        tempLbl.text = "\(Int(currentWeather.currentTemp))°"
        
        //Select the image name that matches the weather type
        weatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    
    //Downloading forecast data for the tableView
    func downloadedForecastData(completed: @escaping DownloadComplete) {
        
        //Where the forecast data is coming from
        let forecastDataURL = URL(string: forecastURL)!
        
        //Alamofire GET request
        Alamofire.request(forecastDataURL).responseJSON { (response) in
            
            //Grab the value from the response result
            let result = response.result.value
            
            //Cast the json object as a Swift Dictionary for usability
            if let dict = result as? [String: Any] {
                
                //Reach the array that holds the data I want
                if let list = dict["list"] as? [[String: Any]] {
                    
                    //Loop for the temp of each unique day
                    for obj in list {
                        
                        //New instance of Forecast with a dictionary that holds each object in the list array
                        let newForecast = Forecast(weatherDict: obj)
                        
                        //Add to Forecast array
                        self.forecasts.append(newForecast)
                        print(obj)
                    }
                    
                }
            }
            completed()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //New Instance of an empty Forecast
//        forecast = Forecast(weatherDict: <#T##[String : Any]#>)
        
        //Instantiate a new CurrentWeather and access the downloadWeatherDetails method to make the request when the app loads
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            
            //Call this method before the UI get updated
            self.downloadedForecastData {
                
                //Setup the UI to load the downloaded data
                self.updateUI()
            }
        }
    }

}

