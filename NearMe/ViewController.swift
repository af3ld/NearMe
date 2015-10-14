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
import SwiftyJSON
import AFNetworking


class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapViewContainer: GMSMapView!
    
    let locationManager = CLLocationManager()
    var geocoder : CLGeocoder = CLGeocoder()
    var placemark : CLPlacemark = CLPlacemark()
    
    let yelp_api_key:String = "YHLpRxukJnjKlqSovUJ1Qw"
    let yelp_api_secret:String = "W3vGmYPT6jc0N5lShpw0OSzeGQk"
    let yelp_api_token:String = "q7sHJImJ41kEI2voGJR04N_od90RVzic"
    let yelp_api_token_secret:String = "lwJz_qaaVezBF9j4IelMekBL2N8"
    
    var latitude: Double = 45.507324
    var longitude: Double = -122.618419
    var cameraZoom : Float = 12
    var postalCode: String = ""
    var locale: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findMe()
        getJSON()
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //activates the reverse geocoder; turning longitude/latitude into a specific location
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
    
    //displays the location from the given placemark
    func displayLocationInfo(placemark: CLPlacemark){
        locationManager.stopUpdatingLocation()
        if placemark.locality != nil {
            locale = placemark.locality!
        }
        if placemark.postalCode != nil{
            postalCode = placemark.postalCode!
//                            print(placemark.postalCode)
        }
        
    }
    
    //activates the location manager and returns the latitude and longitude of the current location
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
    
    
    
    //should return in JSON form the restaurants in the vicinity.
    //Does not work fully
    //Issues with oauth information
    func getJSON(){

        var url = "https://api.yelp.com/v2/search/?location=" + locale
        url = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let client = APIHelper(consumerKey: yelp_api_key, consumerSecret: yelp_api_secret, accessToken: yelp_api_token, accessSecret: yelp_api_token_secret)
      
    
    }
    
    
    
    
}
