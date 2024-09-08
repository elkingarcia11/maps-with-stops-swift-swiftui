import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var position: MapCameraPosition
    @Published var selectedStop: Stop?
    @Published var selectedId: String?
    @Published var showSheet: Bool = false
    @Published var distance: Double = 30_000 // Use underscores for better readability
    @Published var animationDuration: CGFloat = 1.0
    
    // MARK: - Initializer
    
    init(initialPosition: MapCameraPosition? = nil) {
        // Set default values for the camera position if not provided
        let defaultCenter = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let defaultCamera = MapCamera(centerCoordinate: defaultCenter, distance: 30_000)
        self.position = initialPosition ?? .camera(defaultCamera)
    }
    
    // MARK: - Methods
    
    /// Updates the map's camera position to the specified stop with animation.
    /// - Parameter stop: The stop whose coordinates will be used for the new camera position.
    func updatePosition(for stop: Stop) {
        withAnimation(.easeInOut(duration: animationDuration)) {
            position = .camera(MapCamera(
                centerCoordinate: stop.sender.coordinates,
                distance: distance
            ))
        }
    }
    
    /// Handles the dismissal of the sheet by resetting `selectedId` if the sheet is not shown.
    func handleSheetDismiss() {
        if !showSheet {
            selectedId = nil
        }
    }
}
