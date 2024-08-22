import SwiftUI
import CoreLocation

struct StopDetailView: View {
    @ObservedObject var viewModel: StopViewModel
    
    var body: some View {
        ZStack{
            Color(Color.gray)
            VStack {
                HStack{
                    Button("Cancel"){}
                    Spacer()
                    Text("Stop Details")
                        .fontWeight(.bold)
                    Spacer()
                    Button("Done"){}
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                Divider()
               //  CircleWithNumber(number: viewModel.stop.stopOrder, circleColor: .blue, diameter: 75).padding()
                Form{
                    HStack{
                        Image(systemName: "house")
                        Text("Address")
                        Spacer()
                        Button(action: {
                            // Action for the button
                            print("Button tapped")
                        }) {
                            Text("\(viewModel.stop.address)\n\(viewModel.stop.city), \(viewModel.stop.state) \(viewModel.stop.zipCode)")
                                .font(.headline)
                                .multilineTextAlignment(.trailing) // Center text alignment
                                .lineLimit(nil) // Allow multiple lines
                                .padding()
                                .frame(maxWidth: .infinity) // Optionally make the button take full width
                        }
                    }
                    HStack{
                        Image(systemName: "truck.box")
                        Text("Driver")
                        Spacer()
                        Button(action: {
                            // Action for the button
                            print("Button tapped")
                        }) {
                            Text(viewModel.stop.driver)
                                .font(.headline)
                                .multilineTextAlignment(.trailing) // Center text alignment
                                .lineLimit(nil) // Allow multiple lines
                                .padding()
                                .frame(maxWidth: .infinity) // Optionally make the button take full width
                        }
                    }
                    Button(action: {}) {
                        Text("Assign to another driver")
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 20)
                }
                Spacer()
            }
        }
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
        let viewModel = StopViewModel(stop: sampleStop)
        StopDetailView(viewModel: viewModel)
    }
}

// Circle with number inside view
struct CircleWithNumber: View {
    var number: Int
    var circleColor: Color
    var diameter: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: diameter, height: diameter)
            
            Text("\(number)")
                .font(.system(size: diameter / 2))
                .foregroundColor(.white)
        }
    }
}
