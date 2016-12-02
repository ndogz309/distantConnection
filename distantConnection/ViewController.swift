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

class ViewController: UIViewController,CLLocationManagerDelegate {
    
        var manager: CLLocationManager!
        var currentLocation: CLLocation!
    
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        manager=CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
  
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
        manager.stopUpdatingLocation()
 
        
    }

    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

