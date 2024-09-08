import Foundation
import CoreLocation

/// Represents a stop with address details, driver information, and completion status.
struct Stop: Identifiable {
    
    // MARK: - Properties
    
    /// Unique identifier for the stop.
    let id: UUID
    
    /// Date when the stop was created.
    let dateCreated: String
    
    /// Date of the appointment.
    let dateOfAppointment: String
    
    /// Status indicating if the stop has been completed.
    var completed: Bool
    
    /// Customer associated with the stop.
    var sender: Customer
    
    /// Sector related to the stop.
    var sector: String
    
    /// User who created the stop.
    let userCreated: String
    
    /// Date when the stop was last modified.
    let dateModified: String
    
    /// Additional comments related to the stop.
    var comments: String
    
    /// Driver assigned to the stop.
    var driver: String
    
    // MARK: - Static Properties
    
    /// A default instance of `Stop` with placeholder values.
    static let `default` = Stop(
        id: UUID(), dateCreated: "2024-01-01",
        dateOfAppointment: "2024-01-01",
        completed: false,
        sender: Customer(id: UUID(), sender: false, active: true, name: "Default Sender", address: "Default Address", apt: "apt", country: "USA", city: "New York", state: "NY", zip: "10000", coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0), phone: "(718)-562-1300", externalId: "12345678", email: "elkingarcia.11@gmail.com", notes: "Needs special assistance"),
        sector: "Default Sector",
        userCreated: "Default User",
        dateModified: "2024-01-01",
        comments: "Default pick up comments with specific instructions. Default pick up comments with specific instructions.",
        driver: "No driver"
    )
    
    // MARK: - Initializers
    
    /// Initializes a `Stop` with specified details.
    /// - Parameters:
    ///   - id: The unique identifier for the stop.
    ///   - dateCreated: The date when the stop was created.
    ///   - dateOfAppointment: The date of the appointment.
    ///   - completed: The completion status of the stop.
    ///   - sender: The customer associated with the stop.
    ///   - sector: The sector related to the stop.
    ///   - userCreated: The user who created the stop.
    ///   - dateModified: The date when the stop was last modified.
    ///   - comments: Additional comments related to the stop.
    ///   - driver: The driver assigned to the stop.
    init(id: UUID, dateCreated: String, dateOfAppointment: String, completed: Bool, sender: Customer, sector: String, userCreated: String, dateModified: String, comments: String, driver: String) {
        self.id = id
        self.dateCreated = dateCreated
        self.dateOfAppointment = dateOfAppointment
        self.completed = completed
        self.sender = sender
        self.sector = sector
        self.userCreated = userCreated
        self.dateModified = dateModified
        self.comments = comments
        self.driver = driver
    }
}


struct Customer: Identifiable {
    let id: UUID
    let sender: Bool
    let active: Bool
    let name: String
    let address: String
    let apt: String
    let country: String
    let city: String
    let state: String
    let zip: String
    let coordinates : CLLocationCoordinate2D
    let phone : String
    let externalId: String?
    let email: String?
    let notes: String?
}
