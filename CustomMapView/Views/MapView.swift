import SwiftUI
import MapKit

struct MapView : View {
    @StateObject private var locationManager = LocationManager()
    
    @State private var cameraPosition: MapCameraPosition = .camera(
        .init(centerCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), distance: 100, heading: 0)
    )
    
    @Binding var stops: [Stop]
    
    var markerColor: Color
    
    var distance : Double
    
    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(stops.indices, id: \.self) {
                index in
                let stop = stops[index]
                Marker(stop.address, monogram: Text(String(index+1)), coordinate: stop.coordinates).tint(markerColor).tag(index+1)
            }
        }
        .onAppear {
            updateCameraPosition()
        }
    }
    
    private func updateCameraPosition() {
        let centerCoordinate = locationManager.location ?? stops.first?.coordinates ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        cameraPosition = .camera(
            .init(centerCoordinate: centerCoordinate, distance: distance)
        )
    }
    
}
