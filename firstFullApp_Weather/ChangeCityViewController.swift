//
//  ChangeCityViewController.swift
//  firstFullApp_Weather
//
//  Created by Alexander Stevens on 8/31/17.
//  Copyright © 2017 Alex Stevens. All rights reserved.
//

import Foundation
import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class ChangeCityViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet var changeCityTextField: UITextField!
        
    var delegate: ChangeCityDelegate?
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        changeCityTextField.delegate = self
//        let textureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height ))
//        textureImageView.image = UIImage(named: "texture2")
//        textureImageView.alpha = 1
//        view.addSubview(textureImageView)
//        view.bringSubview(toFront: changeCityTextField)
//        view.bringSubview(toFront: enterButton)
//        view.bringSubview(toFront: cancelButton)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let cityName = changeCityTextField.text!
        delegate?.userEnteredANewCityName(city: cityName)
        self.dismiss(animated: true, completion: nil)
        return true
    }
    
    @IBAction func newCityButtonPressed(_ sender: Any) {
        
        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
