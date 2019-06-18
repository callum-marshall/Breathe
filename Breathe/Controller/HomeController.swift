
import UIKit
import Mapbox
import SwiftyJSON
import Alamofire

class HomeController: UIViewController {
        
    // MARK: - Properties
    
    var delegate: HomeControllerDelegate?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
    }
    
    // MARK: - Handlers
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
        
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Side menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger-1").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
}

//class HomeController: UIViewController, MGLMapViewDelegate {
//
//    override func viewDidLoad() {
//
//
//
//        // for each borough
//        for i in 0..<boroughData.count {
//
//            // interpolate the 'lat' and 'lon' in the api URL
//            let apiURL = "http://api.erg.kcl.ac.uk/AirQuality/Data/Nowcast/lat=\(boroughData[i].lat)/lon=\(boroughData[i].lon)/Json"
//
//            // make an API request with the api URL
//            Alamofire.request(apiURL).responseJSON { (responseData) -> Void in
//
//                // if the value of the result isn't nil
//                if((responseData.result.value) != nil) {
//
//                    // save the resulting data (from the key 'PointResult') to a variable
//                    let jsonData = JSON(responseData.result.value!)["PointResult"]
//
//                    // add the response data to the borough object using our new JSON variable
//                    boroughData[i].add(jsonData: jsonData)
//
//                    // print some data in the log for visibility
//                    print(boroughData[i].name, boroughData[i].PM25)
//                }
//            }
//        }
//
//        super.viewDidLoad()
//        // Do any additional setup after loading the view
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
//
//
//    }
//
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        guard annotation is MGLPointAnnotation else {
//            return nil
//        }
//
//        let reuseIdentifier = "\(annotation.coordinate.longitude)"
//
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//
//        if annotationView == nil {
//            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
//            annotationView!.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
//
//            let hue = CGFloat(annotation.coordinate.longitude) / 100
//            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
//        }
//
//        return annotationView
//    }
//
//    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//        return true
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
//
//        for i in 0..<boroughData.count {
//
//            //        Coordinates
//            let coordinates = [
//                CLLocationCoordinate2D(latitude: boroughData[i].lat, longitude: boroughData[i].lon)
//            ]
//
//            //        Point annotations
//            var pointAnnotations = [MGLPointAnnotation]()
//            for coordinate in coordinates {
//                let point = MGLPointAnnotation()
//                point.coordinate = coordinate
//                point.title = boroughData[i].name
//                point.subtitle = "PM10: \(boroughData[i].PM10)"
//                pointAnnotations.append(point)
//            }
//
//            mapView.addAnnotations(pointAnnotations)
//        }
//    }
//
//}

//class CustomAnnotationView: MGLAnnotationView {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        // Use CALayer’s corner radius to turn this view into a circle.
//        layer.cornerRadius = bounds.width / 2
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.white.cgColor
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Animate the border width in/out, creating an iris effect.
//        let animation = CABasicAnimation(keyPath: "borderWidth")
//        animation.duration = 0.1
//        layer.borderWidth = selected ? bounds.width / 4 : 2
//        layer.add(animation, forKey: "borderWidth")
//    }
//}
