import SwiftUI
import MapKit

struct MapScreenView: View {
    @StateObject private var viewModel = MapScreenViewModel()
    @State private var showSheet = false
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(
                stops: viewModel.filteredStops,
                markerColor: .blue,
                distance: 30000,
                animationDuration: 1.0,
                selectedStop: $viewModel.selectedStop,
                showSheet: $showSheet
            )
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showSheet) {
                if let stop = viewModel.selectedStop {
                    StopDetailView(
                        stop: Binding(
                            get: { stop },
                            set: { viewModel.selectedStop = $0 }
                        ),
                        showSheet: $showSheet,
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
