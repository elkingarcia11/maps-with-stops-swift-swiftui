import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var position: MapCameraPosition = .automatic
    @State private var selectedId: String?
    
    @Binding var stops: [Stop]
    
    var markerColor: Color
    var distance: Double
    
    private var selectedStop: Stop? {
        stops.first { $0.address == selectedId }
    }
    
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
            if let stop = selectedStop {
                withAnimation(.easeInOut(duration: 1.0)) {
                    position = .camera(MapCamera(
                        centerCoordinate: stop.coordinates,
                        distance: distance
                    ))
                }
            }
        }


    }
}
