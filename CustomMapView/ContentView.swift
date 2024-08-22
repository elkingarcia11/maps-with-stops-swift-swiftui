import SwiftUI
import MapKit

struct ContentView: View {
    @State private var showSheet = false
    @State private var stops: [Stop] = [
        Stop(address: "78 Post Ave", city: "New York", state: "NY", zipCode: "10034", coordinates: CLLocationCoordinate2D(latitude: 40.8687, longitude: -73.9210), comments: "Llevar 2 caja",
             driver: "Miguel", completed: false),
        Stop(address: "2249 Washington Ave ", city: "Bronx", state: "NY", zipCode: "10457", coordinates: CLLocationCoordinate2D(latitude: 40.8547, longitude: -73.8901), comments: "Llevar 1 caja", driver: "Bronelys", completed: false),
        Stop(address: "133 W 197th St ", city: "Bronx", state: "NY", zipCode: "10468", coordinates: CLLocationCoordinate2D(latitude: 40.8610, longitude: -73.9080), comments: "Recoger 2 caja", driver: "Bronelys", completed: false)
    ]
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DropdownSelectorView()
            
            // Initialize and display MapView
            MapView(stops: $stops, markerColor: .blue, distance: 30000)
                .edgesIgnoringSafeArea(.all)
            /*.sheet(isPresented: $showSheet) {
             OrderListView(viewModel: orderListViewModel, circleColor: .blue, diameter: 33)
             .presentationDetents([.medium, .large])
             }*/
        }
    }
    
}


#Preview {
    ContentView()
}
