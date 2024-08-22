import SwiftUI
import MapKit

struct ContentView: View {
    // Example list of stops for testing
    @State private var stops: [Stop] = [
        Stop(id: UUID(), stopID: "1", address: "123 Main St", city: "New York", state: "NY", zipCode: "10001", coordinates: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), stopOrder: 1, orderListID: "Order1"),
        Stop(id: UUID(), stopID: "2", address: "456 Broadway", city: "New York", state: "NY", zipCode: "10002", coordinates: CLLocationCoordinate2D(latitude: 40.7158, longitude: -74.0030), stopOrder: 2, orderListID: "Order1")
    ]
    var body: some View {
        VStack {
            // Initialize and display MapView
            MapView(stops: $stops)
        }
    }
}

#Preview {
    ContentView()
}
