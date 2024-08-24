import SwiftUI
import CoreLocation
import MapKit

class MapScreenViewModel: ObservableObject {
    // Computed property for filtered stops based on the selected driver
    var filteredStops: [Stop] {
        if selectedDriver == "All Drivers" {
            return stops
        } else {
            return stops.filter { $0.driver == selectedDriver }
        }
    }
    
    @Published var selectedStop: Stop?
    @Published var selectedDriver: String = "All Drivers"
    @Published var drivers: [String] = ["All Drivers", "Bronelys", "Miguel"]
    @Published var position: MapCameraPosition
    @Published var selectedId: String?
    @Published var showSheet: Bool = false
    
    // Add distance and animationDuration if needed
    @Published var distance: Double = 30000
    @Published var animationDuration: CGFloat = 1.0
    
    @Published var stops: [Stop] = [
        Stop(address: "78 Post Ave", city: "New York", state: "NY", zipCode: "10034", coordinates: CLLocationCoordinate2D(latitude: 40.8687, longitude: -73.9210), comments: "Llevar 2 caja",
             driver: "Miguel", completed: false),
        Stop(address: "2249 Washington Ave ", city: "Bronx", state: "NY", zipCode: "10457", coordinates: CLLocationCoordinate2D(latitude: 40.8547, longitude: -73.8901), comments: "Llevar 1 caja", driver: "Bronelys", completed: false),
        Stop(address: "133 W 197th St ", city: "Bronx", state: "NY", zipCode: "10468", coordinates: CLLocationCoordinate2D(latitude: 40.8610, longitude: -73.9080), comments: "Recoger 2 caja", driver: "Bronelys", completed: false)
    ]
    
    init(initialPosition: MapCameraPosition? = nil) {

            // Set a default position to avoid accessing uninitialized properties
            let defaultCenter = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            let defaultCamera = MapCamera(centerCoordinate: defaultCenter, distance: 30000) // Default distance

            // Initialize `position` with the default value or `initialPosition`
            self.position = initialPosition ?? .camera(defaultCamera)
            
            // Now update the position if `stops` is not empty
            if let firstStop = stops.first {
                self.position = .camera(MapCamera(centerCoordinate: firstStop.coordinates, distance: distance))
            }
        }

    func reorderStop(from oldIndex: Int, to newIndex: Int) {
        guard oldIndex >= 0, oldIndex < stops.count, newIndex >= 0, newIndex < stops.count else {
            return
        }
        let movedStop = stops.remove(at: oldIndex)
        stops.insert(movedStop, at: newIndex)
    }
    
    func updateStopDriver(stopId: UUID, newDriver: String) {
        if let index = stops.firstIndex(where: { $0.id == stopId }) {
            stops[index].driver = newDriver
        }
    }
    
    func updateSelectedId(to id: String?) {
        selectedId = id
        if let stop = filteredStops.first(where: { $0.address == selectedId }) {
            withAnimation(.easeInOut(duration: animationDuration)) {
                position = .camera(MapCamera(
                    centerCoordinate: stop.coordinates,
                    distance: distance
                ))
            }
            selectedStop = stop
            showSheet = true
        }
    }
    
    func handleSheetDismiss() {
        if !showSheet {
            selectedId = nil
        }
    }
}
