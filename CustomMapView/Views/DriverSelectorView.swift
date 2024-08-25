import SwiftUI

struct DriverSelectorView: View {
    @Binding var selectedDriver: String
    let role : String
    let numberOfStops: Int
    let drivers: [String]
    
    private let stopIconName: String = "mappin.and.ellipse"
    private let driverIconName: String = "eye"
    private let roundedRectangleCornerRadius: CGFloat = 10
    private let shadowRadius: CGFloat = 5
    private let oneSidedPadding: CGFloat = 8
    
    // Computed property to provide a default value for `selectedDriver`
    private var defaultSelectedDriver: String {
        drivers.first ?? "All Drivers"
    }
    
    // Computed property for formatted stops count
    private var stopsCount: String {
        "\(numberOfStops) stops"
    }
    
    var body: some View {
        HStack {
            // Left element: displays the number of stops
            HStack {
                Image(systemName: stopIconName)
                Text(stopsCount)
            }
            .padding([.top, .bottom, .leading])
            .padding(.trailing, oneSidedPadding)
            
            Divider()
            // Center element: Menu for selecting a driver
            HStack {
                Menu {
                    ForEach(drivers, id: \.self) { driver in
                        Button(action: {
                            selectedDriver = driver
                        }) {
                            Text(driver)
                        }
                    }
                } label: {
                    Label(selectedDriver.isEmpty ? defaultSelectedDriver : selectedDriver, systemImage: driverIconName)
                }
                .disabled(role != "admin")
                Spacer()
            }
            .padding([.top, .bottom])
            .padding(.leading, oneSidedPadding)
            
            Divider()
            // Right element: Button with bullet list icon
            HStack {
                Button(action: {
                    // Action for button can be added here
                }) {
                    Image(systemName: "list.bullet")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: roundedRectangleCornerRadius)
                .fill(Color.white)
                .shadow(radius: shadowRadius)
        )
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    DriverSelectorView(
        selectedDriver: .constant("Driver A"),
        role: "admin",
        numberOfStops: 5,
        drivers: ["Driver A", "Driver B", "Driver C"]
    )
}
