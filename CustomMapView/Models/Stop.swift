import CoreLocation

struct Stop: Identifiable {
    let id: UUID
    let stopID: String
    let address: String
    let city: String
    let state: String
    let zipCode: String
    let coordinates: CLLocationCoordinate2D
    let stopOrder: Int
    let orderListID: String
}
