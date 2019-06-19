
import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case CurrentLocation
    case RecentLocations
    case London
    case Delhi
    case MexicoCity
    case NewYork
    
    var description: String {
        switch self {
        case .CurrentLocation: return "Current Location"
        case .RecentLocations: return "Recent Locations"
        case .London: return "London"
        case .Delhi: return "Delhi"
        case .MexicoCity: return "Mexico City"
        case .NewYork: return "New York"
        }
    }
    var image: UIImage {
        switch self {
        case .CurrentLocation: return UIImage(named: "icons8-marker-50") ?? UIImage()
        case .RecentLocations: return UIImage(named: "icons8-marker-50") ?? UIImage()
        case .London: return UIImage(named: "icons8-world-map-80") ?? UIImage()
        case .Delhi: return UIImage(named: "icons8-world-map-80") ?? UIImage()
        case .MexicoCity: return UIImage(named: "icons8-world-map-80") ?? UIImage()
        case .NewYork: return UIImage(named: "icons8-world-map-80") ?? UIImage()
        }
    }
}
