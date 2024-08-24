import SwiftUI
import MapKit

struct MapWithStopsView: View {
    @StateObject private var viewModel = MapScreenViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(
                position: $viewModel.position, stops: viewModel.filteredStops,
                markerColor: .blue,
                distance: viewModel.distance,
                animationDuration: viewModel.animationDuration,
                selectedStop: $viewModel.selectedStop,
                showSheet: $viewModel.showSheet
            )
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $viewModel.showSheet) {
                if let stop = viewModel.selectedStop {
                    StopDetailView(
                        stop: Binding(
                            get: { stop },
                            set: { viewModel.selectedStop = $0 }
                        ),
                        showSheet: $viewModel.showSheet,
                        viewModel: viewModel
                    )
                    .presentationDetents([.medium, .large])
                }
            }
            
            DropdownSelectorView(selectedDriver: $viewModel.selectedDriver, numberOfStops: viewModel.filteredStops.count, drivers: viewModel.drivers)
                .padding()
        }
    }
}

#Preview {
    MapScreenView()
}
