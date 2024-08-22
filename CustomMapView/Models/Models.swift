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
    let address: String
    let city: String
    let state: String
    let zipCode: String
    let coordinates: CLLocationCoordinate2D
    let comments : String
    let driver : String
    let completed : Bool
}

// Show all stops by default
// Filter by [Driver]
