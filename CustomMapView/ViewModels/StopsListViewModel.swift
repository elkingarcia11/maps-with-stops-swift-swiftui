import SwiftUI
import CoreLocation

class StopListViewModel: ObservableObject {
    // MARK: - Published Properties
    
    // Define a few customers
    let customer1 = Customer(
        id: UUID(),
        sender: true,
        active: true,
        name: "Alice Johnson",
        address: "78 Post Ave",
        apt: "Apt 1A",
        country: "USA",
        city: "New York",
        state: "NY",
        zip: "10034",
        coordinates: CLLocationCoordinate2D(latitude: 40.8687, longitude: -73.9210),
        phone: "(718)-562-4400",
        externalId: "CUST001",
        email: "alice.johnson@example.com",
        notes: "Frequent customer"
    )

    let customer2 = Customer(
        id: UUID(),
        sender: false,
        active: true,
        name: "Bob Smith",
        address: "2249 Washington Ave",
        apt: "2B",
        country: "USA",
        city: "Bronx",
        state: "NY",
        zip: "10457",
        coordinates:
            CLLocationCoordinate2D(latitude: 40.8547, longitude: -73.8901),
        phone: "(718)-562-0000",
        externalId: "CUST002",
        email: "bob.smith@example.com",
        notes: "Requires special handling"
    )

    let customer3 = Customer(
        id: UUID(),
        sender: true,
        active: false,
        name: "Charlie Brown",
        address: "133 W 197th St",
        apt: "Suite 202",
        country: "USA",
        city: "Bronx",
        state: "NY",
        zip: "10468",
        coordinates:
            CLLocationCoordinate2D(latitude: 40.8610, longitude: -73.9080),
        phone: "(718)-562-1300",
        externalId: "CUST003",
        email: nil,
        notes: "Inactive account"
    )

    
    @Published var customers: [Customer]
    @Published var stops: [Stop]

        // MARK: - Initializer

    init() {
        // Initialize the customers array
        customers = [customer1, customer2, customer3]
        // Define stops for the customers
        let stop1 = Stop(
            id: UUID(),
            dateCreated: "2024-08-26",
            dateOfAppointment: "2024-09-01",
            completed: false,
            sender: customer1,
            sector: "Sector A",
            userCreated: "Elkin Garcia",
            dateModified: "2024-08-26",
            comments: "First stop of the day.",
            driver: "Miguel"
        )

        let stop2 = Stop(
            id: UUID(),
            dateCreated: "2024-08-25",
            dateOfAppointment: "2024-09-02",
            completed: false,
            sender: customer2,
            sector: "Sector B",
            userCreated: "Elkin Garcia",
            dateModified: "2024-08-25",
            comments: "Requires special handling.",
            driver: "Bronelys"
        )

        let stop3 = Stop(
            id: UUID(),
            dateCreated: "2024-08-24",
            dateOfAppointment: "2024-09-03",
            completed: true,
            sender: customer3,
            sector: "Sector C",
            userCreated: "Elkin Garcia",
            dateModified: "2024-08-24",
            comments: "Completed on time.",
            driver: "Bronelys"
        )
        stops = [stop1,stop2,stop3]
    }
    
    @Published var selectedDriver: String = "All Drivers"
    @Published var drivers: [String] = ["All Drivers", "Bronelys", "Miguel"]
    
    // MARK: - Computed Properties
    
    var filteredStops: [Stop] {
        selectedDriver == "All Drivers" ? stops : stops.filter { $0.driver == selectedDriver }
    }
    
    // MARK: - Methods
    
    func reorderStop(from oldIndex: Int, to newIndex: Int) {
        // Ensure indices are within bounds and different before proceeding
        guard oldIndex != newIndex, oldIndex >= 0, oldIndex < stops.count, newIndex >= 0, newIndex < stops.count else {
            return
        }
        
        let movedStop = stops.remove(at: oldIndex)
        stops.insert(movedStop, at: newIndex)
    }
    
    func updateStopDriver(stopId: UUID, newDriver: String) {
        guard let index = stops.firstIndex(where: { $0.id == stopId }) else {
            return
        }
        stops[index].driver = newDriver
    }
    
    func updateStopCompletedState(stopId: UUID, newState: Bool){
        guard let index = stops.firstIndex(where: { $0.id == stopId }) else {
            return
        }
        stops[index].completed = newState
        
    }
}
