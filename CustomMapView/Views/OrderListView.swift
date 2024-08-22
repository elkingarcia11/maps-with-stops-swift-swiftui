import SwiftUI
struct OrderListView: View {
    @ObservedObject var viewModel: OrderListViewModel
    private var circleColor: Color
    private var diameter: Double
    
    init(viewModel: OrderListViewModel, circleColor: Color, diameter: Double) {
        self.viewModel = viewModel
        self.circleColor = circleColor
        self.diameter = diameter
    }
    
    var body: some View {
        NavigationView{
            List(viewModel.orderList.stops) { stop in
                HStack {
                    CircleWithNumber(number: stop.stopOrder, circleColor: circleColor, diameter: diameter)
                        .padding(.trailing,8)
                    Text(stop.address)
                        .foregroundStyle(.black)
                    Spacer()
                    Image(systemName: "line.3.horizontal").foregroundStyle(Color(UIColor.systemGray))
                }
            }
            .navigationTitle("Stops")
            .listStyle(PlainListStyle()) // Optional: Removes default list styling for a cleaner look
            .padding() // Optional: Adds padding around the List
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}


#Preview {
    ContentView()
}
