//
//  ViewController.swift
//  Breathe
//
//  Created by Student on 10/06/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
    private let networkingClient = NetworkingClient()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//
//        let mapView = MGLMapView(frame: view.bounds)
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.delegate = self
//
//        mapView.styleURL = MGLStyle.streetsStyleURL
//
//        // coordinates for London, UK
//        let center = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
//
//        // set starting point
//        mapView.setCenter(center, zoomLevel: 6, direction: 0, animated: false)
//
//        view.addSubview(mapView)
//        view.addSubview(textView)
//    }
//
//    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
//        // Wait for the map to load before initiating first camera movement
//
//        // Create a camera that rotates around center point
//
//        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 100000,
//                                  pitch: 3, heading: 0)
//
//        // Animate the camera movement over 5 seconds
//        mapView.setCamera(camera, withDuration: 3, animationTimingFunction:
//            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
//    }
    
    
    @IBAction func executeRequest(_ sender: Any) {
        
        guard let urlToExecute = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
            return
        }
        
        networkingClient.execute(urlToExecute) { (json, error) in
            if let error = error {
                self.textView.text = error.localizedDescription
            } else if let json = json {
                self.textView.text = json.description
            }
        }
    }
    

}

