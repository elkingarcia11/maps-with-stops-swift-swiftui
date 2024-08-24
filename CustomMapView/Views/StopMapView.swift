import SwiftUI
import MapKit

struct StopMapView: View {
    
    @Binding var position: MapCameraPosition
    @State private var selectedId: String?
    
    let stops: [Stop]
    let markerColor: Color
    let distance: Double
    let animationDuration: CGFloat
    
    @Binding var selectedStop: Stop? // Binding to pass selected stop back to ContentView
    @Binding var showSheet: Bool // Binding to control sheet presentation
    
    var body: some View {
        Map(position: $position, selection: $selectedId) {
            ForEach(stops.indices, id: \.self) { index in
                let stop = stops[index]
                Marker(stop.address, monogram: Text(String(index + 1)), coordinate: stop.coordinates)
                    .tint(markerColor)
                    .tag(stop.address)
                    .annotationTitles(.hidden)
            }
        }
        .onChange(of: selectedId) {
            handleSelectedIdChange(selectedId)
        }
        .onChange(of: showSheet) {
            handleShowSheetChange(showSheet)
        }
    }
    
    // Handles changes to the selectedId
    private func handleSelectedIdChange(_ newSelectedId: String?) {
        if let address = newSelectedId,
           let stop = stops.first(where: { $0.address == address }) {
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
    
    // Handles changes to the showSheet binding
    private func handleShowSheetChange(_ newShowSheet: Bool) {
        if !newShowSheet {
            selectedId = nil
        }
    }
}
