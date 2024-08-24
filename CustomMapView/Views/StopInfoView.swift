import SwiftUI
import CoreLocation

struct StopInfoView: View {
    @Binding var stop: Stop
    @Binding var showSheet: Bool
    @ObservedObject var viewModel: StopListViewModel
    
    @State private var selectedIndex: Int
    
    // Custom initializer for setting the initial selectedIndex
    init(stop: Binding<Stop>, showSheet: Binding<Bool>, viewModel: StopListViewModel) {
        _stop = stop
        _showSheet = showSheet
        _selectedIndex = State(initialValue: viewModel.filteredStops.firstIndex(where: { $0.id == stop.wrappedValue.id }) ?? 0)
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                headerView
                
                Divider()
                
                stopInformationView
                
                
                driverInformationView
                
                Spacer()
            }
            .padding(.top)
        }
    }
    
    // Header view with cancel and done buttons
    private var headerView: some View {
        HStack {
            Button("Cancel") {
                showSheet = false
            }
            Spacer()
            Text("Stop Details")
                .fontWeight(.bold)
            Spacer()
            Button("Done") {
                showSheet = false
            }
        }
        .padding()
    }
    
    // Stop information view with address and order picker
    private var stopInformationView: some View {
        VStack {
            HStack {
                Text("STOP INFORMATION")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                Spacer()
            }
            .padding(.leading, 48)
            .padding(.top)
            
            VStack {
                HStack {
                    Label("Address", systemImage: "house")
                        .padding()
                    Spacer()
                    Text("\(stop.address)\n\(stop.city), \(stop.state) \(stop.zipCode)")
                        .font(.headline)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.blue)
                        .padding()
                }
                Divider()
                
                HStack {
                    Label("Current Order", systemImage: "list.number")
                        .padding([.top, .leading, .bottom])
                    Spacer()
                    Picker("Current Order", selection: $selectedIndex) {
                        ForEach(0..<viewModel.filteredStops.count, id: \.self) { index in
                            Text("\(index + 1)").tag(index) // Adjust to match zero-based index
                        }
                    }
                    .onChange(of: selectedIndex) {
                        reorderStop(to: selectedIndex)
                    }
                    .padding([.top, .bottom, .trailing])
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
            )
            .padding(.horizontal, 20)
        }
        .padding(.top)
    }
    
    // Driver information view with driver picker
    private var driverInformationView: some View {
        VStack {
            HStack {
                Text("DRIVER INFORMATION")
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
                Spacer()
            }
            .padding(.leading, 48)
            .padding(.top)
            
            HStack {
                Label("Current Driver", systemImage: "truck.box")
                    .padding([.top, .leading, .bottom])
                Spacer()
                Picker("Current Driver", selection: $stop.driver) {
                    ForEach(viewModel.drivers, id: \.self) { driver in
                        Text(driver).tag(driver)
                    }
                }
                .onChange(of: stop.driver) {
                    viewModel.updateStopDriver(stopId: stop.id, newDriver: stop.driver)
                }
                .padding([.top, .bottom, .trailing])
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
            )
            .padding(.horizontal, 20)
        }
        .padding(.top)
    }
    
    // Reorders the stop in the view model
    private func reorderStop(to newIndex: Int) {
        guard let currentIndex = viewModel.stops.firstIndex(where: { $0.id == stop.id }) else {
            return
        }
        viewModel.reorderStop(from: currentIndex, to: newIndex)
    }
}

struct StopInfoView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for preview
        let sampleStop = Stop.default
        let sampleViewModel = StopListViewModel()
        
        sampleViewModel.drivers = ["Driver A", "Driver B", "Driver C"]
        
        return StopInfoView(stop: .constant(sampleStop), showSheet: .constant(true), viewModel: sampleViewModel)
    }
}
