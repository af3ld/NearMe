//
//  ViewController.swift
//  NearMe
//
//  Created by Alex Feldman on 10/6/15.
//  Copyright © 2015 Alex Feldman. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Alamofire

import OAuthSwift


class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapViewContainer: GMSMapView!
    
    let locationManager = CLLocationManager()
    var geocoder : CLGeocoder = CLGeocoder()
    var placemark : CLPlacemark = CLPlacemark()
    
    var latitude: Double = 45.507324
    var longitude: Double = -122.618419
    var cameraZoom : Float = 12
    var postalCode: String = ""
    var locale: String = ""

    let yelp_api_key:String = "YHLpRxukJnjKlqSovUJ1Qw"
    let yelp_api_secret:String = "W3vGmYPT6jc0N5lShpw0OSzeGQk"
    let yelp_api_token:String = "WW1PJiUP9RagnvJiS4IYHlCjjXfy-HS3"
    let yelp_api_token_secret:String = "7OfmO9imvtbgr0hfq-CcQPR7cLw"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findMe()
        get()
        
        let camera = GMSCameraPosition.cameraWithLatitude(latitude,
            longitude: longitude, zoom: cameraZoom)
        let mapFrame = CGRect(x: 0.0, y: 0.0, width: mapViewContainer.frame.width, height: mapViewContainer.frame.height)
        let mapView = GMSMapView.mapWithFrame(mapFrame, camera: camera)
        mapView.myLocationEnabled = true
        mapView.mapType = kGMSTypeNormal
        mapView.indoorEnabled = false
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        
        mapView.delegate = self
        
        mapViewContainer.addSubview(mapView)
        
        
        //        var marker = GMSMarker()
        //        marker.position = camera.target
        //        marker.appearAnimation = kGMSMarkerAnimationPop
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
        //        marker.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                //println(“Reverse geocoder failed with error” + error.localizedDescription)
                print("Reverse geocode failed with error")
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                // println(“Problem with the data received from geocoder”)
                print("Problem with the date recieved from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
            locationManager.stopUpdatingLocation()
            if placemark.locality != nil {
                locale = placemark.locality!
//                print(placemark.locality)
            }
            if placemark.postalCode != nil{
                postalCode = placemark.postalCode!
//                print(placemark.postalCode)
            }

        }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("An error has occured while updating location: " + error.localizedDescription)
    }
    
    
    
    func findMe(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let locale = locationManager.location
        
        if (locale != nil) {
            latitude = locationManager.location!.coordinate.latitude
            longitude = locationManager.location!.coordinate.longitude
        }
        print("current latitude : \(latitude)")
        print ("current longitude :  \(longitude)")
        
    }
    

    func get(){
        Alamofire.request(.GET, search, parameters: ["api_key": yelp_api_key]).responseJSON { request, response, result in
            switch result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                
            case .Failure(let data, let error):
                print("Request failed with error: \(error)")
                
                if let data = data {
                    print("Response data: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
                }
            }
        }
        
    }
    

    func yelpURLBuilder() -> String{
        
        
        var yelp_search_location: String = "https://api.yelp.com/v2/search/?location="
        var yelp_search_location_end: String = "&category_filter=pizza"
        let url = NSURL(string: "https://api.yelp.com/v2/")
        
        
    }
    
    
    
}
