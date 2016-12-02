//
//  ViewController.swift
//  distantConnection
//
//  Created by Nicole Atack on 12/2/16.
//  Copyright © 2016 Nicole Atack. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class ViewController: UIViewController,CLLocationManagerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    var manager: CLLocationManager!
    var currentLocation: CLLocation!
    let geocoder = CLGeocoder()
    var toLocation: CLLocation!
    
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        addressTextField.delegate = self
        
        
        manager=CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
 
        
   
    }
    
    
    @IBAction func geocodeButtonPressed(_ sender: Any) {
        
        
        geocodeAddress()
    
    addressTextField.endEditing(true)
    
    
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        
        geocodeAddress()
        return true
    }
    
    
    

    
    func locationManager(_: CLLocationManager, didUpdateLocations: [CLLocation]){
        print("here")
   setCurrentLocation()
        
    }
    
    
    
    func setCurrentLocation(){
        
        
        currentLocation=manager.location
        
     
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        
        print("lat isssss")
        print (lat)
        
        print ("long is")
        print(long)

 
        
    }

    
    func geocodeAddress() {
        let address = addressTextField.text
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
            let placemark = placemarks?[0]
            let geoLat=placemark?.location!.coordinate.latitude
            let geoLong=placemark?.location!.coordinate.longitude
            
            self.toLocation = CLLocation(latitude: geoLat!, longitude: geoLong!)
            
            print("tooooooo loccccation")
            print(self.toLocation)
            
            print("geolat is")
            print(geoLat)
            
            print ("geolong isssssss")
            print(geoLong)
            
self.calculateDistance()
            
        })
        
 
    }

    
    
    func calculateDistance(){
       
        print(toLocation)
        print(currentLocation)
        
        let distance = currentLocation.distance(from: self.toLocation)
        
        print("----------distance is")
        print(distance)
        let distanceInt = Int(distance)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.string(from: NSNumber(value: distanceInt))
        
        distanceLabel.text=numberFormatter.string(from: NSNumber(value: distanceInt))

    
        
    }
    

    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

