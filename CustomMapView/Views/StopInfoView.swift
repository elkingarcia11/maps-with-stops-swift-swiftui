import SwiftUI
import CoreLocation

struct StopInfoView: View {
    @Binding var stop: Stop
    @Binding var showSheet: Bool
    @ObservedObject var viewModel: StopListViewModel
    @State private var selectedIndex: Int
    var role : String
    
    @State var tempOrder : Int
    @State var tempDriver : String
    
    // Custom initializer for setting the initial selectedIndex
    init(stop: Binding<Stop>, showSheet: Binding<Bool>, viewModel: StopListViewModel, role: String) {
        _stop = stop
        _showSheet = showSheet
        _selectedIndex = State(initialValue: viewModel.filteredStops.firstIndex(where: { $0.id == stop.wrappedValue.id }) ?? 0)
        self.viewModel = viewModel
        self.role = role
        self._tempOrder = State(initialValue: _selectedIndex.wrappedValue)
        self._tempDriver = State(initialValue: stop.wrappedValue.driver)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                headerView
                
                Divider()
                
                stopInformationView
                
                applyButtonView
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
                if tempOrder != selectedIndex {
                    reorderStop(to: tempOrder)
                }
                if stop.driver != tempDriver {
                    viewModel.updateStopDriver(stopId: stop.id, newDriver: tempDriver)
                }
                showSheet = false
            }
        }
        .padding()
    }
    
    // Stop information view with address and order picker
    private var stopInformationView: some View {
        VStack {
            VStack {
                HStack {
                    Label("Address", systemImage: "house")
                    Spacer()
                    Text("\(stop.sender.address)\n\(stop.sender.city), \(stop.sender.state)\n\(stop.sender.zip)")
                        .fontWeight(.medium)
                        .multilineTextAlignment(.trailing)
                }
                .padding()
                Divider()
                
                HStack {
                    Label("Current Order", systemImage: "list.number")
                    Spacer()
                    Picker("Current Order", selection: $tempOrder) {
                        ForEach(0..<viewModel.filteredStops.count, id: \.self) { index in
                            Text("\(index + 1)").tag(index) // Adjust to match zero-based index
                        }
                    }
                }
                .padding(role == "admin" ? EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16) : EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                
                if role == "admin" {
                    Divider()
                    HStack {
                        Label("Current Driver", systemImage: "truck.box")
                        Spacer()
                        Picker("Current Driver", selection: $tempDriver) {
                            ForEach(viewModel.drivers, id: \.self) { driver in
                                Text(driver).tag(driver)
                            }
                        }
                    }
                    .padding()
                }
                /*
                 Divider()
                 HStack{
                 Toggle(isOn: $stop.completed) {
                 Label("Mark as completed", systemImage: "checkmark.circle")
                 .foregroundColor(stop.completed ? .green : .primary)
                 }
                 .toggleStyle(SwitchToggleStyle(tint: .green))
                 .padding()
                 .onChange(of: stop.completed) {
                 viewModel.updateStopCompletedState(stopId: stop.id, newState: stop.completed)
                 }
                 }*/
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
            )
            .padding()
        }
    }
    
    
    private var applyButtonView: some View {
        Button(action: {
            if tempOrder != selectedIndex {
                reorderStop(to: tempOrder)
            }
            if stop.driver != tempDriver {
                viewModel.updateStopDriver(stopId: stop.id, newDriver: tempDriver)
            }
            showSheet = false
        }) {
            Text("Apply")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding([.top, .leading, .trailing], 20)
        
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
        let role = "user"
        sampleViewModel.drivers = ["Driver A", "Driver B", "Driver C"]
        
        return StopInfoView(stop: .constant(sampleStop), showSheet: .constant(true), viewModel: sampleViewModel, role: role)
    }
}
