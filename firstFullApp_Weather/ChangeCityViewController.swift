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

class ChangeCityViewController: UIViewController {
    
    
    @IBOutlet var changeCityTextField: UITextField!
        
    var delegate: ChangeCityDelegate?
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {

    }
    
    @IBAction func newCityButtonPressed(_ sender: Any) {
        
        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
