//
//  Constants.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/5/17.
//  Copyright © 2017 Italyte. All rights reserved.
//

import Foundation

//Global constants accessible throughout the entire app
let baseURL = "http://api.openweathermap.org/data/2.5/weather?"
let latitude = "lat="
let longitude = "&lon="
let appID = "&appid="
let apiKey = "0bd0ea0097839e2557720ca13df4d640"

//Tell the download function when it's completed
typealias DownloadComplete = () -> ()

//The weather URL based on the user's location. The location coordinates MUST be unwrapped
let currentWeatherURL = "\(baseURL)\(latitude)\(Location.sharedInstance.latitude!)\(longitude)\(Location.sharedInstance.longitude!)\(appID)\(apiKey)"

//The weather forecast URL based on the user's location. The location coordinates MUST be unwrapped
let forecastURL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=0bd0ea0097839e2557720ca13df4d640"

