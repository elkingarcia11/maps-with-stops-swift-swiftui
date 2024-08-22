import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var position: MapCameraPosition
    @State private var selectedId: String?
    
    let stops: [Stop]
    let markerColor: Color
    let distance: Double
    let animationDuration: CGFloat
    
    // Computed property to get the selected stop
    private var selectedStop: Stop? {
        stops.first { $0.address == selectedId }
    }
    
    // Initializer
    init(stops: [Stop], markerColor: Color, distance: Double, animationDuration: CGFloat, initialPosition: MapCameraPosition? = nil) {
        self.stops = stops
        self.markerColor = markerColor
        self.distance = distance
        self.animationDuration = animationDuration
        _position = State(initialValue: initialPosition ?? .camera(MapCamera(centerCoordinate: stops.first?.coordinates ?? CLLocationCoordinate2D(), distance: distance)))
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
                withAnimation(.easeInOut(duration: animationDuration)) {
                    position = .camera(MapCamera(
                        centerCoordinate: stop.coordinates,
                        distance: distance
                    ))
                }
            }
        }
    }
}
