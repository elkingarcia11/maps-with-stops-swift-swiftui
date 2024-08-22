import SwiftUI
import MapKit

struct MapView : View {
    @Binding var stops: [Stop]
    var markerColor : Color = .blue
    var body: some View {
        Map {
            ForEach(stops){
                stop in
                Marker(stop.address, monogram: Text(String(stop.stopOrder)), coordinate: stop.coordinates).tint(markerColor)
                
            }
        }
    }
}
