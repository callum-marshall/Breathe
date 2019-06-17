
import UIKit
import Mapbox
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, MGLMapViewDelegate {
    
    override func viewDidLoad() {

        // for each borough
        for i in 0..<boroughData.count {
            
            // interpolate the 'lat' and 'lon' in the api URL
            let apiURL = "http://api.erg.kcl.ac.uk/AirQuality/Data/Nowcast/lat=\(boroughData[i].lat)/lon=\(boroughData[i].lon)/Json"
            
            // make an API request with the api URL
            Alamofire.request(apiURL).responseJSON { (responseData) -> Void in
                
                // if the value of the result isn't nil
                if((responseData.result.value) != nil) {
                    
                    // save the resulting data (from the key 'PointResult') to a variable
                    let jsonData = JSON(responseData.result.value!)["PointResult"]
                    
                    // add the response data to the borough object using our new JSON variable
                    boroughData[i].add(jsonData: jsonData)
                    
                    // print some data in the log for visibility
                    print(boroughData[i].name, boroughData[i].PM25)
                }
            }
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view

        let mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self

        mapView.styleURL = MGLStyle.streetsStyleURL

        // coordinates for London, UK
        let center = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)

        // set starting point
        mapView.setCenter(center, zoomLevel: 6, direction: 0, animated: false)

        view.addSubview(mapView)
        
//        Coordinates
        let coordinates = [
            CLLocationCoordinate2D(latitude: 51.5099, longitude: -0.0059)
        ]
        
//        Point annotations
        var pointAnnotations = [MGLPointAnnotation]()
        for coordinate in coordinates {
            let point = MGLPointAnnotation()
            point.coordinate = coordinate
            point.title = "\(coordinate.latitude), \(coordinate.longitude)"
            pointAnnotations.append(point)
        }
        
        mapView.addAnnotations(pointAnnotations)
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
