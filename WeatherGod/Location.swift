//
//  Location.swift
//  WeatherGod
//
//  Created by Roydon Jeffrey on 1/9/17.
//  Copyright © 2017 Italyte. All rights reserved.
//


import CoreLocation

class Location {
    
    //Singleton to pass data to the properties of this class
    static var sharedInstance = Location()
    
    private init() {}
    
    //Coordinates
    var latitude: Double!
    var longitude: Double!
}
