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
        
        Alamofire.request("http://api.erg.kcl.ac.uk/AirQuality/Data/Nowcast/lat=51.5191/lon=0.0739/Json").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print("hello warld")
                print(swiftyJsonVar["PointResult"]["@O3"])
                print(swiftyJsonVar["PointResult"]["@NO2"])
                print(swiftyJsonVar["PointResult"]["@PM10"])
                print(swiftyJsonVar["PointResult"]["@PM25"])
                print(swiftyJsonVar["PointResult"]["@lon"])
                print(swiftyJsonVar["PointResult"]["@lat"])
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
