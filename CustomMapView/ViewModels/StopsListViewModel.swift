import SwiftUI
import CoreLocation

class StopListViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var stops: [Stop] = [
        Stop(address: "78 Post Ave", city: "New York", state: "NY", zipCode: "10034", coordinates: CLLocationCoordinate2D(latitude: 40.8687, longitude: -73.9210), comments: "Llevar 2 caja",
             driver: "Miguel", completed: false),
        Stop(address: "2249 Washington Ave", city: "Bronx", state: "NY", zipCode: "10457", coordinates: CLLocationCoordinate2D(latitude: 40.8547, longitude: -73.8901), comments: "Llevar 1 caja", driver: "Bronelys", completed: false),
        Stop(address: "133 W 197th St", city: "Bronx", state: "NY", zipCode: "10468", coordinates: CLLocationCoordinate2D(latitude: 40.8610, longitude: -73.9080), comments: "Recoger 2 caja", driver: "Bronelys", completed: false)
    ]
    
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
