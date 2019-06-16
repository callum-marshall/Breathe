
import UIKit
import Mapbox
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, MGLMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        struct borough {
            let name: String
            let lat: Double
            let lon: Double
        }
        
        struct boroughs {
            let boroughs: [borough]
        }
        
        let boroughData = [
            borough(
                name: "City of London",
                lat: 51.5155,
                lon: -0.0922
            )
        ]
//      For every borough in the array
        for i in 0..<boroughData.count {
//          Make an API request
        Alamofire.request("http://api.erg.kcl.ac.uk/AirQuality/Data/Nowcast/lat=\(boroughData[i].lat)/lon=\(boroughData[i].lon)/Json").responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    let jsonData = swiftyJsonVar["PointResult"]
//                  Wrap the response in an object
                    let cityOfLondonData:LocationData = LocationData(
                        name: "\(boroughData[i].name)",
                        jsonData: jsonData
                    )
                    print(cityOfLondonData.name, cityOfLondonData.PM25)
                }
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
