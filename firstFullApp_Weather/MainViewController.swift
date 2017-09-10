//
//  MainViewController.swift
//  firstFullApp_Weather
//
//  Created by Alexander Stevens on 8/17/17.
//  Copyright © 2017 Alex Stevens. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    let APIkey = "2daaa76ee90d95a4aba4c6f3f866b288"
    let APIurl = "http://api.openweathermap.org/data/2.5/forecast"
    
    let weatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    
    // MARK: UI Elements
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var day0Label: UILabel!
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    
    @IBOutlet weak var day0Icon: UIImageView!
    @IBOutlet weak var day1Icon: UIImageView!
    @IBOutlet weak var day2Icon: UIImageView!
    @IBOutlet weak var day3Icon: UIImageView!
    @IBOutlet weak var day4Icon: UIImageView!
    
    @IBOutlet weak var temp0Label: UILabel!
    @IBOutlet weak var temp1Label: UILabel!
    @IBOutlet weak var temp2Label: UILabel!
    @IBOutlet weak var temp3Label: UILabel!
    @IBOutlet weak var temp4Label: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBAction func animateSecondController(_ sender: Any) {
        
        
        let transitionDelegate = ExpandingViewTransition(expandingView: sender as! UIView,
                                                         expandViewAnimationDuration: 1,
                                                         presentVCAnimationDuration: 0.1)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeCityViewController")
        vc.transitioningDelegate = transitionDelegate
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    let horizontalBar: UIImage = UIImage(named: "icons8-Horizontal Line Filled-50 copy1")!
    
    var initialImageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    @IBAction func circlePressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        updateLabelsWithCurrentDaysOfWeek()
        
    }
    
    // MARK: Getting and Handling the Weather Data
    
    
    func getWeatherData(url: String, parameters: [String : String]){
        
        Alamofire.request(url, method: .get, parameters:parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got weatherData")
                let weatherJSON : JSON  = JSON(response.result.value!)
                self.updateWeatherDataModel(json: weatherJSON)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                self.day0Label.text = "Connection Issues"
            }
            
        }
    }
    
    func updateWeatherDataModel(json: JSON){
        
        if json["list"][0]["main"]["temp"].double != nil {//this value is in Kelvin
            
            weatherDataModel.cityName = json["city"]["name"].stringValue
            
            weatherDataModel.conditionsArray.append(json["list"][0]["weather"][0]["id"].intValue) //now
            weatherDataModel.conditionsArray.append(json["list"][8]["weather"][0]["id"].intValue) //24 hours away
            weatherDataModel.conditionsArray.append(json["list"][16]["weather"][0]["id"].intValue)//48 hours away
            weatherDataModel.conditionsArray.append(json["list"][24]["weather"][0]["id"].intValue) //72 hours away
            weatherDataModel.conditionsArray.append(json["list"][32]["weather"][0]["id"].intValue)///96 hours away
            
            weatherDataModel.temperatureArray.append(json["list"][0]["main"]["temp"].stringValue)
            weatherDataModel.temperatureArray.append(json["list"][8]["main"]["temp"].stringValue)
            weatherDataModel.temperatureArray.append(json["list"][16]["main"]["temp"].stringValue)
            weatherDataModel.temperatureArray.append(json["list"][24]["main"]["temp"].stringValue)
            weatherDataModel.temperatureArray.append(json["list"][32]["main"]["temp"].stringValue)
            
            weatherDataModel.conditionsArray.forEach({ (i) in
                weatherDataModel.weatherIconNameArray.append(weatherDataModel.updateWeatherIconPicture(condition: i))
            })
            
            for i in 0...4 {
                weatherDataModel.temperatureArray[i] = convertKelvinToFahrenheitAndRemoveDecimals(kelvin: weatherDataModel.temperatureArray[i])
            }
            
            updateUIWithWeatherData()
            
        } else {
            //handle this
        }
        
    }
    
    // MARK: Updating the UI
    func setupSelectionBar(){
        view.addSubview(initialImageview)
        initialImageview.image = nil
        initialImageview.frame = CGRect(x: day0Label.frame.origin.x, y: day0Label.frame.origin.y + 5, width: day0Label.frame.width, height: 50)
        initialImageview.image = horizontalBar
        
    }
    
    func updateUIWithWeatherData(){
        setupSelectionBar()

        day0Icon.image = UIImage(named: weatherDataModel.weatherIconNameArray[0])
        day1Icon.image = UIImage(named: weatherDataModel.weatherIconNameArray[1])
        day2Icon.image = UIImage(named: weatherDataModel.weatherIconNameArray[2])
        day3Icon.image = UIImage(named: weatherDataModel.weatherIconNameArray[3])
        day4Icon.image = UIImage(named: weatherDataModel.weatherIconNameArray[4])
        temp0Label.text = String(weatherDataModel.temperatureArray[0]) + "°f"
        temp1Label.text = String(weatherDataModel.temperatureArray[1]) + "°f"
        temp2Label.text = String(weatherDataModel.temperatureArray[2]) + "°f"
        temp3Label.text = String(weatherDataModel.temperatureArray[3]) + "°f"
        temp4Label.text = String(weatherDataModel.temperatureArray[4]) + "°f"
        
        //AnimatedWeatherViewController.sharedInstance.cityLabel.text = "Bexley"
        
        AnimatedWeatherViewController.sharedInstance.weatherIconName = weatherDataModel.weatherIconNameArray[0]
        let animatedView = AnimatedWeatherViewController.sharedInstance.view
        animatedView?.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        self.containerView.addSubview(animatedView!)
    }
    
    func convertKelvinToFahrenheitAndRemoveDecimals(kelvin: String) -> String {
        
        let kelvinFloat = Float(kelvin)
        let fahrenheitFloat: Float = (kelvinFloat! - 273.15) * 9/5 + 32
        let roundedUpFahrenheitInt: Int = Int(ceilf(fahrenheitFloat))
        return String(roundedUpFahrenheitInt)
        
    }
    
    @IBAction func day0tapped(_ sender: Any) {
        initialImageview.image = nil
        initialImageview.frame = CGRect(x: day0Label.frame.origin.x, y: day0Label.frame.origin.y + 5, width: day0Label.frame.width, height: 50)
        initialImageview.image = horizontalBar
        AnimatedWeatherViewController.sharedInstance.dayPressed = 0
        AnimatedWeatherViewController.sharedInstance.weatherIconName = weatherDataModel.weatherIconNameArray[0]
        AnimatedWeatherViewController.sharedInstance.changeViewToMatchCurrentWeather()
    }
    
    @IBAction func day1tapped(_ sender: Any) {
        initialImageview.image = nil
        initialImageview.frame = CGRect(x: day1Label.frame.origin.x, y: day1Label.frame.origin.y + 5, width: day1Label.frame.width, height: 50)
        initialImageview.image = horizontalBar
        AnimatedWeatherViewController.sharedInstance.dayPressed = 1
        AnimatedWeatherViewController.sharedInstance.weatherIconName = weatherDataModel.weatherIconNameArray[1]
        AnimatedWeatherViewController.sharedInstance.changeViewToMatchCurrentWeather()
        
    }
    
    @IBAction func day2tapped(_ sender: Any) {
        initialImageview.image = nil
        initialImageview.frame = CGRect(x: day2Label.frame.origin.x, y: day2Label.frame.origin.y + 5, width: day2Label.frame.width, height: 50)
        initialImageview.image = horizontalBar
        AnimatedWeatherViewController.sharedInstance.dayPressed = 2
        AnimatedWeatherViewController.sharedInstance.weatherIconName = weatherDataModel.weatherIconNameArray[2]
        AnimatedWeatherViewController.sharedInstance.changeViewToMatchCurrentWeather()
        
    }
    
    @IBAction func day3tapped(_ sender: Any) {
        initialImageview.image = nil
        initialImageview.frame = CGRect(x: day3Label.frame.origin.x, y: day3Label.frame.origin.y + 5, width: day3Label.frame.width, height: 50)
        initialImageview.image = horizontalBar
        AnimatedWeatherViewController.sharedInstance.dayPressed = 3
        AnimatedWeatherViewController.sharedInstance.weatherIconName = weatherDataModel.weatherIconNameArray[3]
        AnimatedWeatherViewController.sharedInstance.changeViewToMatchCurrentWeather()
    }
    
    @IBAction func day4tapped(_ sender: Any) {
        initialImageview.image = nil
        initialImageview.frame = CGRect(x: day4Label.frame.origin.x, y: day4Label.frame.origin.y + 5, width: day4Label.frame.width, height: 50)
        initialImageview.image = horizontalBar
        AnimatedWeatherViewController.sharedInstance.dayPressed = 4
        AnimatedWeatherViewController.sharedInstance.weatherIconName = weatherDataModel.weatherIconNameArray[4]
        AnimatedWeatherViewController.sharedInstance.changeViewToMatchCurrentWeather()
        
    }
    
    
}

// MARK: Location Delegate

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String:String] = ["lat" : latitude, "lon" : longitude, "appid" : APIkey]
            getWeatherData(url: APIurl, parameters: params)
            weatherDataModel.conditionsArray.removeAll()
            weatherDataModel.temperatureArray.removeAll()
            weatherDataModel.weatherIconNameArray.removeAll()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
// MARK: Handle Days of Week

extension MainViewController {
    func updateLabelsWithCurrentDaysOfWeek() {
        let numberOfDayInWeek = Calendar.current.dateComponents([.weekday], from: Date()).weekday
        
        switch numberOfDayInWeek {
        case 1?:
            day0Label.text = "Sun"
            day1Label.text = "Mon"
            day2Label.text = "Tues"
            day3Label.text = "Wed"
            day4Label.text = "Thurs"
        case 2?:
            day0Label.text = "Mon"
            day1Label.text = "Tues"
            day2Label.text = "Wed"
            day3Label.text = "Thurs"
            day4Label.text = "Fri"
        case 3?:
            day0Label.text = "Tues"
            day1Label.text = "Wed"
            day2Label.text = "Thurs"
            day3Label.text = "Fri"
            day4Label.text = "Sat"
        case 4?:
            day0Label.text = "Wed"
            day1Label.text = "Thurs"
            day2Label.text = "Fri"
            day3Label.text = "Sat"
            day4Label.text = "Sun"
        case 5?:
            day0Label.text = "Thurs"
            day1Label.text = "Fri"
            day2Label.text = "Sat"
            day3Label.text = "Sun"
            day4Label.text = "Mon"
        case 6?:
            day0Label.text = "Fri"
            day1Label.text = "Sat"
            day2Label.text = "Sun"
            day3Label.text = "Mon"
            day4Label.text = "Tues"
        case 7?:
            day0Label.text = "Sat"
            day1Label.text = "Sun"
            day2Label.text = "Mon"
            day3Label.text = "Tues"
            day4Label.text = "Wed"
        default:
            day0Label.text = "Mon"
            day1Label.text = "Tues"
            day2Label.text = "Wed"
            day3Label.text = "Thurs"
            day4Label.text = "Fri"
        }
        
    }
    
}
