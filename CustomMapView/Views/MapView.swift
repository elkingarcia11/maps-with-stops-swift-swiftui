import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var position: MapCameraPosition
    @State private var selectedId: String?
    
    let stops: [Stop]
    let markerColor: Color
    let distance: Double
    let animationDuration: CGFloat
    
    @Binding var selectedStop: Stop? // Binding to pass selected stop back to ContentView
    @Binding var showSheet: Bool // Binding to control sheet presentation
    
    // Initializer
    init(stops: [Stop], markerColor: Color, distance: Double, animationDuration: CGFloat, selectedStop: Binding<Stop?>, showSheet: Binding<Bool>, initialPosition: MapCameraPosition? = nil) {
        self.stops = stops
        self.markerColor = markerColor
        self.distance = distance
        self.animationDuration = animationDuration
        _selectedStop = selectedStop
        _showSheet = showSheet
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
            if showSheet == false {
                selectedId = nil
            }
        }
    }
}
