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
    
    var dayPressed: Int = 0
    var weatherIconName: String? = nil
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        changeViewToMatchCurrentWeather()
        setupGradiantBorder()
        
        
    }
    
    func setupGradiantBorder(){
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: view.frame.size)
        let myBlue = UIColor(colorLiteralRed: 0.1725, green: 0.4314, blue: 0.9843, alpha: 1) //##2C6EFB
        let myPurple = UIColor(colorLiteralRed: 0.7098, green: 0.2275, blue: 0.9882, alpha: 1)//#B53AFC
        gradient.colors = [myBlue.cgColor, myPurple.cgColor]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 7
        shape.path = UIBezierPath(rect: view.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        view.layer.addSublayer(gradient)
    }
    
    func changeViewToMatchCurrentWeather(){
        
        guard weatherIconName != nil else { return }
        
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
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
    
    
    func showCloudLightning(){
        removeSubviews()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ANIMATIONtstorm"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 160)
        imageView.contentMode = .scaleAspectFit
        
        let animation = setupAnimation()
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
    }
    func showCloudDrizzleAlt(){
        removeSubviews()
        
    }
    
    func showCloudRainSun(){
        removeSubviews()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ANIMATIONpartlycloudrain"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 160)
        imageView.contentMode = .scaleAspectFit
        
        let animation = setupAnimation()
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
    }
    func showCloudSnow(){
        removeSubviews()
        
    }
    func showCloudRain(){
        removeSubviews()
        
    }
    func showCloudSnowAlt(){
        removeSubviews()
        
    }
    func showCloudFogAlt(){
        removeSubviews()
        
    }
    func showTornado(){
        removeSubviews()
        
    }
    func showSun(){
        
        removeSubviews()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ANIMATIONsun"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 160)
        imageView.contentMode = .scaleAspectFit
        
        let animation = setupAnimation()
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
    }
    func showCloudSun(){
        
        removeSubviews()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ANIMATIONpartlycloudy"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 160)
        imageView.contentMode = .scaleAspectFit
        
        let animation = setupAnimation()
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
        
        
    }
    func showCloud(){
        
        removeSubviews()
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ANIMATIONcloud"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 160)
        imageView.contentMode = .scaleAspectFit
        
        let animation = setupAnimation()
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
    }
    
    func showWind(){
        removeSubviews()
        
    }
    
    func setupAnimation() -> CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.duration = 2.5
        return animation
    }
    
    func removeSubviews(){
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func customPath() -> UIBezierPath {
        let path = UIBezierPath()
        let endpoint = CGPoint(x: view.frame.height / 2, y: view.frame.width / 2)
        let controlPoint1 = CGPoint(x: view.frame.origin.x/3, y: view.frame.origin.y/3)
        path.move(to: CGPoint(x: 0, y: view.frame.origin.y + view.frame.height))
        path.addCurve(to: endpoint, controlPoint1: controlPoint1, controlPoint2: endpoint)
        return path
    }
    
    
}



