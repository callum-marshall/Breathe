
import Foundation
import SwiftyJSON

class LocationData {
    var name: String
    var lat: Double
    var lon: Double
    var O3: Double
    var NO2: Double
    var PM10: Double
    var PM25: Double

    init(name: String, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.O3 = 0.00
        self.NO2 = 0.00
        self.PM10 = 0.00
        self.PM25 = 0.00
    }
    
    func add(jsonData: JSON) {
//      assigns JSON string values to local variables
        let O3 = jsonData["@O3"].stringValue
        let NO2 = jsonData["@NO2"].stringValue
        let PM10 = jsonData["@PM10"].stringValue
        let PM25 = jsonData["@PM25"].stringValue
//      converts the local variable strings to doubles
//      and assigns them to class variables
        self.O3 = (O3 as NSString).doubleValue
        self.NO2 = (NO2 as NSString).doubleValue
        self.PM10 = (PM10 as NSString).doubleValue
        self.PM25 = (PM25 as NSString).doubleValue
    }
    
}
