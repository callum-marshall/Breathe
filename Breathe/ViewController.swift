//
//  ViewController.swift
//  Breathe
//
//  Created by Student on 10/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import Mapbox
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, MGLMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    Alamofire.request("http://api.erg.kcl.ac.uk/AirQuality/Data/Nowcast/lat=51.517360/lon=-0.073399/Json").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                let jsonData = swiftyJsonVar["PointResult"]
                
//              THIS IS HORRIBLE - - SORRY :(
                let stringO3 = jsonData["@O3"].stringValue
                let doubleO3 = (stringO3 as NSString).doubleValue
                let stringNO2 = jsonData["@NO2"].stringValue
                let doubleNO2 = (stringNO2 as NSString).doubleValue
                let stringPM10 = jsonData["@PM10"].stringValue
                let doublePM10 = (stringPM10 as NSString).doubleValue
                let stringPM25 = jsonData["@PM25"].stringValue
                let doublePM25 = (stringPM25 as NSString).doubleValue
                let stringLon = jsonData["@lon"].stringValue
                let doubleLon = (stringLon as NSString).doubleValue
                let stringLat = jsonData["@lat"].stringValue
                let doubleLat = (stringLat as NSString).doubleValue
//              YUK     YUK     YUK     YUK     YUK
                
                let aldgateData:LocationData = LocationData(
                    name: "Aldgate",
                    O3: doubleO3,
                    NO2: doubleNO2,
                    PM10: doublePM10,
                    PM25: doublePM25,
                    lon: doubleLon,
                    lat: doubleLat
                )

                print(aldgateData.name)
                print(aldgateData.O3)
                print(aldgateData.NO2)
                print(aldgateData.PM10)
                print(aldgateData.PM25)
                print(aldgateData.lat)
                print(aldgateData.lon)
    
            }
        }

        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self

        mapView.styleURL = MGLStyle.streetsStyleURL

        // coordinates for London, UK
        let center = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)

        // set starting point
        mapView.setCenter(center, zoomLevel: 6, direction: 0, animated: false)

        view.addSubview(mapView)
    }

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating first camera movement

        // Create a camera that rotates around center point

        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 100000,
                                  pitch: 3, heading: 0)

        // Animate the camera movement over 5 seconds
        mapView.setCamera(camera, withDuration: 3, animationTimingFunction:
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
    
}
