//
//import Foundation
//import Alamofire
//import SwiftyJSON
//
//class NetworkingClient {
//
//    func execute(lat: String, lon: String) {
//
//        let url = "http://api.erg.kcl.ac.uk/AirQuality/Data/Nowcast/lat=\(lat)/lon=\(lon)/Json"
//
//        Alamofire.request(url).responseJSON { response in
//            if((response.result.value) != nil) {
//                let jsonData = JSON(response.result.value!)["PointResult"]
//            }
//        }
//    }
//}
