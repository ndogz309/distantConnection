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
    
    @IBOutlet weak var arrowView: UIView!
    
    var manager: CLLocationManager!
    var currentLocation: CLLocation!
    let geocoder = CLGeocoder()
    var toLocation: CLLocation!
    var angleDegrees:Double!

    
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        addressTextField.delegate = self
        
        
        manager=CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy=kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
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
        setCurrentLocation { (success) -> Void in
            if success {
                print("compppplllllleeeeeetiiiiiiioooooonnnnnnnnnnnnnnnnnn ")
                calculateDistance()
 
            }
        }
    }
    
    
    func locationManager(_: CLLocationManager, didUpdateHeading: CLHeading){
        
 //do we want true or magnetic north???
        
        print("i am pointing")
        print(manager.heading?.trueHeading)
        
        print("heading accuracy")
        print(manager.heading?.headingAccuracy)
        
        calculateAngle()

         var rotationDegrees = angleDegrees-(manager.heading?.trueHeading)!
        print("need to rotate image by")
        print(rotationDegrees)
        arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(degreesToRadians(degrees: rotationDegrees)))
        
    }
    
    
func setCurrentLocation(completion: (_ success: Bool) -> Void){
        
        
        currentLocation=manager.location
        
        var lat = currentLocation.coordinate.latitude
        var long = currentLocation.coordinate.longitude
        
        print("lat isssss")
        print (lat)
        
        print ("long is")
        print(long)
        manager.stopUpdatingLocation()
        
        
        
        completion(true)
        
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
            self.manager.startUpdatingLocation()
            self.manager.startUpdatingHeading()
            
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
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
    
    
    
    
    func calculateAngle() {
        
        //bearing calculations:  http://www.movable-type.co.uk/scripts/latlong.html
        //need to check this
        
        
        let lat1 = degreesToRadians(degrees: currentLocation.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: currentLocation.coordinate.longitude)
        
        let lat2 = degreesToRadians(degrees: toLocation.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: toLocation.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        print("angleeeee issssssss")
        print(radiansToDegrees(radians: radiansBearing))

        angleDegrees=radiansToDegrees(radians: radiansBearing)
        
       // var rotationDegrees = angleDegrees-(manager.heading?.trueHeading)!
        //print("need to rotate image by")
        //print(rotationDegrees)
        
        
        
        
    }


    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

