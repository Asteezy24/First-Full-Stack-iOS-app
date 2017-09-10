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
        //changeViewToMatchCurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeViewToMatchCurrentWeather()
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
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
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
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
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
        view.addSubview((RadialGradientView(frame: view.frame)))
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ANIMATIONsun"))
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        imageView.contentMode = .scaleAspectFit
        
        let animation = setupAnimation()
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
    }
    func showCloudSun(){
        
        removeSubviews()

        
    }
    func showCloud(){
        
        removeSubviews()
        let radialView = RadialGradientView(frame: view.frame)
        view.bringSubview(toFront: radialView)
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ANIMATIONcloud"))
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
        imageView.contentMode = .scaleAspectFit
        
        let animation = setupAnimation()
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
    }
    
    func showWind(){
        view.backgroundColor = UIColor.gray
        
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
    
    
}

fileprivate func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    let endpoint = CGPoint(x: AnimatedWeatherViewController.sharedInstance.view.frame.height / 2, y: AnimatedWeatherViewController.sharedInstance.view.frame.width / 2)
    let controlPoint1 = CGPoint(x: 100, y: 100)
    path.move(to: CGPoint(x: 0, y: AnimatedWeatherViewController.sharedInstance.view.frame.origin.y + AnimatedWeatherViewController.sharedInstance.view.frame.height))
    path.addCurve(to: endpoint, controlPoint1: controlPoint1, controlPoint2: endpoint)
    return path
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        let path = customPath()
        path.lineWidth = 0
        path.stroke()
        
    }
}

class RadialGradientView: UIView {
    
    @IBInspectable var outsideColor: UIColor = UIColor.blue
    @IBInspectable var insideColor: UIColor = UIColor.init(colorLiteralRed: 0.6, green: 0.76, blue: 1, alpha: 1) // #99c2ff
    
    override func draw(_ rect: CGRect) {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        let context = UIGraphicsGetCurrentContext()
        
        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
}
