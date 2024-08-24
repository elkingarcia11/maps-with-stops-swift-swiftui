import Foundation
import CoreLocation

/// Represents a stop with address details, driver information, and completion status.
struct Stop: Identifiable {
    
    // MARK: - Properties
    
    /// Unique identifier for the stop.
    let id = UUID()
    
    /// Address of the stop.
    var address: String
    
    /// City of the stop.
    var city: String
    
    /// State of the stop.
    var state: String
    
    /// Zip code of the stop.
    var zipCode: String
    
    /// Geographical coordinates of the stop.
    var coordinates: CLLocationCoordinate2D
    
    /// Additional comments related to the stop.
    var comments: String
    
    /// Driver assigned to the stop.
    var driver: String
    
    /// Status indicating if the stop has been completed.
    var completed: Bool
    
    // MARK: - Static Properties
    
    /// A default instance of `Stop` with placeholder values.
    static let `default` = Stop(
        address: "Default Address",
        city: "Default City",
        state: "Default State",
        zipCode: "00000",
        coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        comments: "No comments",
        driver: "No driver",
        completed: false
    )
    
    // MARK: - Initializers
    
    /// Initializes a `Stop` with specified details.
    /// - Parameters:
    ///   - address: The address of the stop.
    ///   - city: The city of the stop.
    ///   - state: The state of the stop.
    ///   - zipCode: The zip code of the stop.
    ///   - coordinates: The geographical coordinates of the stop.
    ///   - comments: Additional comments related to the stop.
    ///   - driver: The driver assigned to the stop.
    ///   - completed: The completion status of the stop.
    init(address: String, city: String, state: String, zipCode: String, coordinates: CLLocationCoordinate2D, comments: String, driver: String, completed: Bool) {
        self.address = address
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.coordinates = coordinates
        self.comments = comments
        self.driver = driver
        self.completed = completed
    }
}
