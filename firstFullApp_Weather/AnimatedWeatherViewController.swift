//
//  AnimatedWeatherViewController.swift
//  firstFullApp_Weather
//
//  Created by Alexander Stevens on 8/25/17.
//  Copyright © 2017 Alex Stevens. All rights reserved.
//

import Foundation
import UIKit

class AnimatedWeatherViewController: UIViewController {
    
    static let sharedInstance = AnimatedWeatherViewController()
    
    var dayPressed: Int = 0
    var weatherIconName: String? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: -5, height: 10)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        changeViewToMatchCurrentWeather()
    }
    
    func changeViewToMatchCurrentWeather(){
        
        guard weatherIconName != nil else { return }
        
        print(weatherIconName as Any)
        
        switch weatherIconName {
        case "Sun"?:
            showSun()
        case "Cloud"?:
            showCloud()
        case "Cloud-Lightning"?:
            showCloudLightning()
        case "Cloud-Drizzle-Alt"?:
            showCloudDrizzleAlt()
        case "Cloud-Rain-Sun"?:
            showCloudRainSun()
        case "Cloud-Snow"?:
            showCloudSnow()
        case "Cloud-Rain"?:
            showCloudRain()
        case "Cloud-Snow-Alt"?:
            showCloudSnowAlt()
        case "Cloud-Fog-Alt"?:
            showCloudFogAlt()
        case "Tornado"?:
            showTornado()
        case "Cloud-Sun"?:
            showCloudSun()
        case "Wind"?:
            showWind()
        default:
            view.backgroundColor = UIColor.clear
        }
    }
    
    
    func showCloudLightning(){
        view.backgroundColor = UIColor.red
    }
    func showCloudDrizzleAlt(){
        view.backgroundColor = UIColor.blue

    }
    func showCloudRainSun(){
        view.backgroundColor = UIColor.green

    }
    func showCloudSnow(){
        view.backgroundColor = UIColor.cyan

    }
    func showCloudRain(){
        view.backgroundColor = UIColor.yellow

    }
    func showCloudSnowAlt(){
        view.backgroundColor = UIColor.purple

    }
    func showCloudFogAlt(){
        view.backgroundColor = UIColor.brown

    }
    func showTornado(){
        view.backgroundColor = UIColor.black

    }
    func showSun(){
        view.backgroundColor = UIColor.orange

    }
    func showCloudSun(){
        view.backgroundColor = UIColor.darkGray

    }
    func showCloud(){
        view.backgroundColor = UIColor.lightGray

    }
    func showWind(){
        view.backgroundColor = UIColor.gray

    }
    
    
}
