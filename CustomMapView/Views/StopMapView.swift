import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var position: MapCameraPosition
    @State var selectedId: String?
    
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
            if let stop = stops.first(where: { $0.address == selectedId }) {
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
        .onChange(of: showSheet){
            if !showSheet {
                selectedId = nil
            }
        }
    }
}
