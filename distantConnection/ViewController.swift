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
    let geocoder = CLGeocoder()
    
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        manager=CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
 
        
        
        geocodeAddress()
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
        let address = "2779 21st street san fransisco"
        
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
            let placemark = placemarks?[0]
            let geoLat=placemark?.location!.coordinate.latitude
            let geoLong=placemark?.location!.coordinate.longitude
            
    
            print("geolat is")
            print(geoLat)
            
            print ("geolong isssssss")
            print(geoLong)

            
        })
        
 
    }

    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

