import SwiftUI
struct StopDetailView: View {
    @ObservedObject var viewModel: StopViewModel
    
    var body: some View {
        VStack {
            Text("Stop ID: \(viewModel.stop.stopID)")
            Text("Address: \(viewModel.stop.address)")
            Text("City: \(viewModel.stop.city)")
            Text("State: \(viewModel.stop.state)")
            Text("Zip Code: \(viewModel.stop.zipCode)")
            Text("Order: \(viewModel.stop.stopOrder)")
        }
    }
}
