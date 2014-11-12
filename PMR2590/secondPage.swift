//
//  secondPage.swift
//  PMR2590
//
//  Created by revmob on 10/29/14.
//  Copyright (c) 2014 poli. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class secondPage: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, FBLoginViewDelegate, FBPlacePickerDelegate {
    
        @IBOutlet var fbLoginView : FBLoginView!
    
        @IBOutlet var latitudeValue: UILabel!
    
        @IBOutlet var longitudeValue: UILabel!
    
        @IBOutlet var myAddress: UILabel!
    
        @IBOutlet var myMap: MKMapView!
    
        var sendLocation: String = ""
    
        var manager = CLLocationManager()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            // Core Location
            
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()

            
            // -23.587468, -46.657707
            
//            var latitude: CLLocationDegrees = -23.587468
//            
//            var longitude: CLLocationDegrees = -46.657707
//            
//            var latDelta: CLLocationDegrees = 0.015
//            
//            var lonDelta: CLLocationDegrees = 0.015
//            
//            var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
//            
//            var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude)
//            
//            var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//            
//            myMap.setRegion(region, animated: true)
//            
//            var annotation = MKPointAnnotation()
//            
//            annotation.coordinate = location
//            
//            annotation.title = "Parque do Ibirapuera"
//            
//            annotation.subtitle = "Where dogs shit"
//            
//            myMap.addAnnotation(annotation)
//
//            var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
//            
//            uilpgr.minimumPressDuration = 2.0
//            
//            myMap.addGestureRecognizer(uilpgr)

        }
    
//        func action(gestureRecognizer: UIGestureRecognizer){
//            
//            var touchPoint = gestureRecognizer.locationInView(self.myMap)
//            
//            var newCoordinate:CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
//            
//            var newAnnotation = MKPointAnnotation()
//            
//            newAnnotation.coordinate = newCoordinate
//            
//            newAnnotation.title = "New Point"
//            
//            newAnnotation.subtitle = "Where??"
//            
//            myMap.addAnnotation(newAnnotation)
//            
//        }
   
        func locationManager(manager:CLLocationManager, didUpdateLocations locations: AnyObject){

            var userLocation: CLLocation = locations[0] as CLLocation
            
            var latitude: CLLocationDegrees = userLocation.coordinate.latitude
            
            var longitude: CLLocationDegrees = userLocation.coordinate.longitude
            
            latitudeValue.text = "\(userLocation.coordinate.latitude)"
            
            longitudeValue.text = "\(userLocation.coordinate.longitude)"
            
            var latDelta: CLLocationDegrees = 0.015
            
            var lonDelta: CLLocationDegrees = 0.015
            
            var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude)
            
            var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            myMap.setRegion(region, animated: true)
            
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) in
            
                if (error != nil) {
                    println("Error1: \(error)")
                } else {
                    
                    let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                    
                    self.myAddress.text = " \(p.subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.postalCode) \n \(p.country)"
                    
                    self.sendLocation = "\(p.thoroughfare), \(p.subThoroughfare) - \(p.subLocality), \(p.postalCode), \(p.country)"
                
                }
            
            })
            
        }
    
        func locationManager(manager: CLLocationManager!, didFailWithError error: NSError) {
            println(error)
        }
    
        @IBAction func checkIn(sender: AnyObject) {
            var textToSend = self.sendLocation
            FBRequestConnection.startWithGraphPath("me/feed", parameters: ["message": "I'm at \(sendLocation)", ], HTTPMethod: "POST") { (connection, res, error) -> Void in
                println("ok bitch")
            }
            
            
//            FBRequestConnection.startForPostStatusUpdate(self.myAddress.text, completionHandler: { (connection, result, error) -> Void in
//                if (error != nil){
//                    println("Funfou!")
//                    println(result)
//                    println(connection)
//                } else {
//                    println(error)
//                }
//            })
        }
    
        func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
            self.performSegueWithIdentifier("firstPage", sender: self)
            println("User Logged Out")
        }
        
        func loginView(loginView : FBLoginView!, handleError:NSError) {
            println("Error: \(handleError.localizedDescription)")
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    


}
