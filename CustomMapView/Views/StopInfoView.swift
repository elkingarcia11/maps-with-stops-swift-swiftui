import SwiftUI
import CoreLocation

struct StopDetailView: View {
    @Binding var stop: Stop
    @Binding var showSheet: Bool
    @ObservedObject var viewModel: MapScreenViewModel
    
    @State private var selectedIndex: Int
    
    init(stop: Binding<Stop>, showSheet: Binding<Bool>, viewModel: MapScreenViewModel) {
        _stop = stop
        _showSheet = showSheet
        _selectedIndex = State(initialValue: viewModel.filteredStops.firstIndex(where: { $0.id == stop.wrappedValue.id }) ?? 0)
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
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
                
                Divider()
                
                VStack{
                    HStack{
                        Text("STOP INFORMATION")
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Color(.systemGray))
                        Spacer()
                    }
                    .padding(.leading, 48)
                    .padding(.top)
                    
                    VStack{
                        HStack {
                            Label("Address", systemImage: "house").padding()
                            Spacer()
                            Text("\(stop.address)\n\(stop.city), \(stop.state) \(stop.zipCode)")
                                .font(.headline)
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.blue).padding()
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
                        Divider()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                    )
                    .padding(.horizontal, 20)
                    
                    VStack{
                        HStack{
                            Text("DRIVER INFORMATION")
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(Color(.systemGray))
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
                    Spacer()
                }.padding(.top)
                
            }
        }
    }
    
    private func reorderStop(to newIndex: Int) {
        guard let currentIndex = viewModel.stops.firstIndex(where: { $0.id == stop.id }) else {
            return
        }
        viewModel.reorderStop(from: currentIndex, to: newIndex)
    }
}

struct StopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for preview
        let sampleStop = Stop(
            address: "123 Main St",
            city: "Bronx",
            state: "NY",
            zipCode: "10453",
            coordinates: CLLocationCoordinate2D(latitude: 40.8467, longitude: -73.9320),
            comments: "Llevar 1 caja",
            driver: "Bronelys",
            completed: false
        )
        
        // Use @State to create a mutable instance
        @State var stateStop = sampleStop
        @State var showSheet = true
        StopDetailView(stop: $stateStop, showSheet: $showSheet, viewModel: MapScreenViewModel())
    }
}
