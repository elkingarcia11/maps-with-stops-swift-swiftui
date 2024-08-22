import SwiftUI
struct OrderListView: View {
    @ObservedObject var viewModel: OrderListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.orderList.stops) { stop in
                Button(action: {
                    viewModel.selectStop(stop)
                }) {
                    Text(stop.stopID)
                }
            }
            .navigationBarTitle("Stops")
            
            if let selectedStop = viewModel.selectedStop {
                StopDetailView(viewModel: StopViewModel(stop: selectedStop))
            } else {
                Text("Select a stop")
            }
        }
    }
}
