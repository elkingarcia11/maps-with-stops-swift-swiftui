import SwiftUI

class StopViewModel: ObservableObject {
    @Published var stop: Stop
    
    init(stop: Stop) {
        self.stop = stop
    }
}
