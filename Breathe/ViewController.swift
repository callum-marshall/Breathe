
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
               
                let aldgateData:LocationData = LocationData(
                    name: "Aldgate",
                    jsonData: jsonData
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
