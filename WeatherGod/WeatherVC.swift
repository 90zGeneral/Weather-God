//
//  WeatherVC.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/3/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit
import CoreLocation     //Apple Framework to access a device's current longitude & laitude location
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var theSky: UIView!
    
    //Location Manager
    let locationManager: CLLocationManager! = CLLocationManager()
    var currentLocation: CLLocation!
    
    //Declare new varaibles of type CurrentWeather & Forecast
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    
    //Array of Forecast
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Allow the locationManager to find your exact location when the app is in use and monitor any significant changes in your location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Instantiate a new CurrentWeather
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Call function for location authorization status
        locationAuthStatus()
    }
    
    //To authorize your location status
    func locationAuthStatus() {
        
        //Check if user's permission was already granted and proceed
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {

            //Store the location determined by locationManager as the currentLocation
            currentLocation = locationManager.location
            
            //Assign the lat & long coordinates from currentLocation  to the lat & long properties of the Location class
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            
            //Access the downloadWeatherDetails method to make the request once the location is determined
            currentWeather.downloadWeatherDetails {
                
                //Call this method before the UI get updated
                self.downloadedForecastData {
                    
                    //Setup the UI to load the downloaded data
                    self.updateUI()
                }
            }
            
        }else {
            
            //Ask the user's permission to access their location
            locationManager.requestWhenInUseAuthorization()
            
            //Call this function again
            locationAuthStatus()
        }
    }
    
    //How many sections should the tableView have?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //How many rows should be in the section?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    //Setting up the content for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cast cell as a ForecastCell for accessibilty to its configureCell method
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastCell {
            
            //Assign each Forecast in the array to each cell created in the tableView
            let eachForecast = forecasts[indexPath.row]
            
            //Call the configureCell method on the cell and pass in a Forecast from the array for each row in the tableView
            cell.configureCell(forecast: eachForecast)
            
            //Then return the cell
            return cell
            
        }else {
            
            return ForecastCell()
        }
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
        if weatherTypeLbl.text == "Haze" {
            weatherImage.image = UIImage(named: "Mist")
        }else {
            weatherImage.image = UIImage(named: currentWeather.weatherType)
        }
        
        //To set The Sky's background depending on the weather type
        if weatherTypeLbl.text == "Clear" {
            theSky.backgroundColor = UIColor(red: 0.00, green: 0.60, blue: 1.00, alpha: 1.0)
            
        }else if  weatherTypeLbl.text == "Mist" || weatherTypeLbl.text == "Haze" {
            theSky.backgroundColor = UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.0)
            
        }else if weatherTypeLbl.text == "Clouds" || weatherTypeLbl.text == "Snow" {
            theSky.backgroundColor = UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.0)
            
        }else if weatherTypeLbl.text == "Thunderstorm" || weatherTypeLbl.text == "Rain" {
            theSky.backgroundColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.0)
            
        }else if weatherTypeLbl.text == "Partially Cloudy" {
            theSky.backgroundColor = UIColor(red: 0.00, green: 0.40, blue: 0.60, alpha: 1.0)
        }
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
                        
                        //Add no more than 8 items to the Forecast array
                        if self.forecasts.count < 8 {
                            self.forecasts.append(newForecast)
                        }
                        print(obj)
                    }
                    
                    //Remove the 1st Forecast so that the 1st cell displays the following day and NOT the current day
                    self.forecasts.remove(at: 0)
                    
                    //Reload the tableView with the data
                    self.tableView.reloadData()
                    
                }
            }
            completed()
        }
    }
}

