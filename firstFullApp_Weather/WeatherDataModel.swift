//
//  WeatherDataModel.swift
//  firstFullApp_Weather
//
//  Created by Alexander Stevens on 8/24/17.
//  Copyright © 2017 Alex Stevens. All rights reserved.
//

import Foundation

class WeatherDataModel {
        
    var cityName: String = ""
    var conditionsArray: [Int] = []
    var temperatureArray: [String] = []
    var weatherIconNameArray: [String] = []
    
    func updateWeatherIconPicture(condition: Int) -> String{
        
        switch (condition) {
            
        case 0...232 :
            return "Cloud-Lightning"
        case 300...321 :
            return "Cloud-Drizzle-Alt"
        case 500...504 :
            return "Cloud-Rain-Sun"
        case 511:
            return "Cloud-Snow"
        case 520...531:
            return "Cloud-Rain"
        case 600...622 :
            return "Cloud-Snow-Alt"
        case 701...780 :
            return "Cloud-Fog-Alt"
        case 781:
            return "Tornado"
        case 800 :
            return "Sun"
        case 801 :
            return "Cloud-Sun"
        case 802...804 :
            return "Cloud"
        case 900 :
            return "Tornado"
        case 901...902:
            return "Cloud-Lightning"
        case 951...962 :
            return "Wind"
        default:
            return "idk"
        }
        
    }
    
}
