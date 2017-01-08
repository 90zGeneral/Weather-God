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

//Prototype url
let currentWeatherURL = "\(baseURL)\(latitude)7\(longitude)11\(appID)\(apiKey)"


let forecastURL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=7&lon=11&cnt=10&mode=json&appid=0bd0ea0097839e2557720ca13df4d640"

