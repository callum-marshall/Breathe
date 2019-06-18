
import UIKit
import Mapbox
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView!
    let layerIdentifier = "statistical-gis-boundaries-lo-c0wr80"
    
    
    override func viewDidLoad() {
        
        // for each borough
        for i in 0..<boroughData.count {
            
            // interpolate the ‘lat’ and ‘lon’ in the api URL
            let apiURL = "http://api.erg.kcl.ac.uk/AirQuality/Data/Nowcast/lat=\(boroughData[i].lat)/lon=\(boroughData[i].lon)/Json"
            
            // make an API request with the api URL
            Alamofire.request(apiURL).responseJSON { (responseData) -> Void in
                
                // if the value of the result isn’t nil
                if((responseData.result.value) != nil) {
                    
                    // save the resulting data (from the key ‘PointResult’) to a variable
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
        
        mapView.showsUserLocation = true
        
        
        // coordinates for London, UK
        let center = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
        
        // set starting point
        mapView.setCenter(center, zoomLevel: 6, direction: 0, animated: false)
        
        view.addSubview(mapView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(singleTap)
        
        let centerScreenPoint:CGPoint = mapView.convert(mapView.centerCoordinate, toPointTo: nil)
        
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        // Load a tileset containing U.S. states and their population density. For more information about working with tilesets, see: https://www.mapbox.com/help/studio-manual-tilesets/
        let url = URL(string: "mapbox://xain08.8hlzdj8n")!
        let source = MGLVectorTileSource(identifier: "statistical-gis-boundaries-lo-c0wr80", configurationURL: url)
        style.addSource(source)
        
        let layer = MGLFillStyleLayer(identifier: layerIdentifier, source: source)
        
        // Access the tileset layer.
        layer.sourceLayerIdentifier = "statistical-gis-boundaries-lo-c0wr80"
        
        
    }
    

    @objc @IBAction func handleMapTap(sender: UITapGestureRecognizer) {
        
        let tapPoint: CGPoint = sender.location(in: mapView)
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
        print("You tapped at: \(tapCoordinate.latitude), \(tapCoordinate.longitude)")

//        let spot = sender.location(in: mapView)
//        let features = mapView.visibleFeatures(at: spot, styleLayerIdentifiers:
//            Set([layerIdentifier]))
//
//        print("double")
       
    }
    
    func changeOpacity(name: String) {
        guard let layer = mapView.style?.layer(withIdentifier: layerIdentifier) as? MGLFillStyleLayer else {
            fatalError("Could not cast to specified MGLFillStyleLayer")
        }
        // Check if a state was selected, then change the opacity of the states that were not selected.
        if !name.isEmpty {
            layer.fillOpacity = NSExpression(format: "TERNARY(name = %@, 1, 0)", name)
        } else {
            // Reset the opacity for all states if the user did not tap on a state.
            layer.fillOpacity = NSExpression(forConstantValue: 1)
        }
    }
    

 
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView!.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 0.5)
        }
        
        return annotationView
    }
    

    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
        
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
            
            //        Point annotations
            var pointAnnotations = [MGLPointAnnotation]()
            for coordinate in coordinates {
                let point = MGLPointAnnotation()
                point.coordinate = coordinate
                point.title = boroughData[i].name
                point.subtitle = "O3: \(boroughData[i].O3)"
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
            //        layer.borderWidth = 0
            //        layer.borderColor = UIColor.white.cgColor
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Animate the border width in/out, creating an iris effect.
            //        let animation = CABasicAnimation(keyPath: “borderWidth”)
            //        animation.duration = 0.1
            //        layer.borderWidth = selected ? bounds.width / 8 : 2
            //        layer.add(animation, forKey: “borderWidth”)
        }
    }
    
    
    
}



