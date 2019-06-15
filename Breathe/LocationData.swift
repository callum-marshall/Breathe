
import Foundation

class LocationData {
    var name: String
    var O3: Double
    var NO2: Double
    var PM10: Double
    var PM25: Double
    var lon: Double
    var lat: Double
    
    init(name: String, O3: Double, NO2: Double, PM10: Double, PM25: Double, lon: Double, lat: Double) {
        self.name = name
        self.O3 = O3
        self.NO2 = NO2
        self.PM10 = PM10
        self.PM25 = PM25
        self.lon = lon
        self.lat = lat
    }
}
