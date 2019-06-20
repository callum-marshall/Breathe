
import UIKit
import Mapbox
import SwiftyJSON
import Alamofire

class HomeController: UIViewController, MGLMapViewDelegate {
        
    // MARK: - Properties
    
    var delegate: HomeControllerDelegate?
    var setLocation = [69.00, -60.118092]
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        
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
        
                let url = URL(string: "mapbox://styles/xain08/cjx1kdz9u278u1cpivf40mqux")
                let mapView = MGLMapView(frame: view.bounds, styleURL: url)
                mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                mapView.delegate = self
        
                // coordinates for London, UK
                let center = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
        
                // set starting point
                mapView.setCenter(center, zoomLevel: 6, direction: 0, animated: false)
        
                view.addSubview(mapView)
                print(mapView)
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
            
            annotationView!.backgroundColor = UIColor(displayP3Red: 0.403, green: 0.447, blue: 0.439, alpha: 0.3)
        }
        
        
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
        
    }
    
    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        return UIButton(type: .detailDisclosure)
    }
    
    
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
        mapView.deselectAnnotation(annotation, animated: false)
        
        // Show an alert containing the annotation's details
        
        let alert = UIAlertController(title: annotation.title!!, message: annotation.subtitle!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating first camera movement
        
        // Create a camera that rotates around center point
        
        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 100000,
                                  pitch: 3, heading: 0)
        
        // Animate the camera movement over 5 seconds
        mapView.setCamera(camera, withDuration: 3, animationTimingFunction:
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        
        for i in 0..<boroughData.count {
            
            //        Coordinates
            let coordinates = [
                CLLocationCoordinate2D(latitude: boroughData[i].lat, longitude: boroughData[i].lon)
            ]
            
            let O3 = boroughData[i].O3
            let strO3 = String(format: "%.3f", O3)
            let NO2 = boroughData[i].NO2
            let strNO2 = String(format: "%.3f", NO2)
            let PM10 = boroughData[i].PM10
            let strPM10 = String(format: "%.3f", PM10)
            let PM25 = boroughData[i].PM25
            let strPM25 = String(format: "%.3f", PM25)
            
            let info: String = "Pollution Stats (µg/m3) \n Ozone: \(strO3)\n Nitrogen Dioxide: \(strNO2)\n Particulate Matter 2.5: \(strPM25)\n Particulate Matter 10:\(strPM10)"
            
            
            //        Point annotations
            var pointAnnotations = [MGLPointAnnotation]()
            for coordinate in coordinates {
                let point = MGLPointAnnotation()
                point.coordinate = coordinate
                point.title = boroughData[i].name
                point.subtitle = info
                
                pointAnnotations.append(point)
            }
            mapView.addAnnotations(pointAnnotations)
        }
    }
    
    class CustomAnnotationView: MGLAnnotationView {
        override func layoutSubviews() {
            super.layoutSubviews()
    
            // Use CALayer’s corner radius to turn this view into a circle.
            layer.cornerRadius = bounds.width / 2
            layer.borderWidth = 0
//            layer.borderColor = UIColor.white.cgColor
        }
    
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
    
            // Animate the border width in/out, creating an iris effect.
            let animation = CABasicAnimation(keyPath: "borderWidth")
            animation.duration = 0.1
        }
    }

    // MARK: - Handlers
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
        
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Breathe"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger-1").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
}
