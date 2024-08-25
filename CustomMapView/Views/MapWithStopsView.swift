import SwiftUI
import MapKit

struct MapWithStopsView: View {
    @StateObject private var stopListViewModel = StopListViewModel()
    @StateObject private var mapViewModel = MapViewModel()
    @StateObject private var driverListViewModel = DriverListViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            // Map view with stops and other configurations
            StopMapView(
                position: $mapViewModel.position,
                stops: stopListViewModel.filteredStops,
                markerColor: .blue,
                distance: mapViewModel.distance,
                animationDuration: mapViewModel.animationDuration,
                selectedStop: $mapViewModel.selectedStop,
                showSheet: $mapViewModel.showSheet
            )
            .onAppear(perform: updateMapPosition)
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $mapViewModel.showSheet) {
                if let selectedStop = mapViewModel.selectedStop {
                    StopInfoView(
                        stop: Binding(
                            get: { selectedStop },
                            set: { mapViewModel.selectedStop = $0 }
                        ),
                        showSheet: $mapViewModel.showSheet,
                        viewModel: stopListViewModel,
                        role:  driverListViewModel.role
                    )
                    .presentationDetents([.medium, .large])
                }
            }
            
            // Driver selector view
            DriverSelectorView(
                selectedDriver: $stopListViewModel.selectedDriver,
                role : driverListViewModel.role, 
                numberOfStops: stopListViewModel.filteredStops.count,
                drivers: driverListViewModel.drivers
            )
            .padding()
        }
    }
    
    private func updateMapPosition() {
        // Update map position with the first stop or a default value
        if let firstStop = stopListViewModel.stops.first {
            mapViewModel.updatePosition(for: firstStop)
        }
    }
}

#Preview {
    MapWithStopsView()
}
