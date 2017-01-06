//
//  WeatherVC.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/3/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Declare a new varaible of type CurrentWeather
    var currentWeather: CurrentWeather!
    
    
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
        tempLbl.text = "\(Int(currentWeather.currentTemp))"
        
        //Select the image name that matches the weather type
        weatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Instantiate a new CurrentWeather and access the downloadWeatherDetails method to make the request when the app loads
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            
            //Setup the UI to load the downloaded data
            self.updateUI()
        }
    }

}

