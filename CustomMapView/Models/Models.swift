import Foundation
import CoreLocation

struct Driver : Identifiable {
    let id = UUID()
    var name : String // Miguel, Bronelys, Dotel, Basilio
    var routes : [Route] // [Bronx, Queens / Long Island, Brooklyn/Queens, Brooklyn, Yonkers Bronx, New Jersey, Connecticut]
}

struct Route: Identifiable {
    let id = UUID()
    var name : String // Bronx, Queens / Long Island, Brooklyn/Queens, Brooklyn, Yonkers Bronx, New Jersey, Connecticut
    var cityState : [String] // ["Bronx, NY", "New York, NY", "Bridgeport, CT"]
}


struct Stop: Identifiable {
    let id = UUID()
    var address: String
    var city: String
    var state: String
    var zipCode: String
    var coordinates: CLLocationCoordinate2D
    var comments : String
    var driver : String
    var completed : Bool
}

// Show all stops by default
// Filter by [Driver]
