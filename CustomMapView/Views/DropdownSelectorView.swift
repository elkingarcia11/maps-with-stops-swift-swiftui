import SwiftUI

struct DropdownSelectorView: View {
    @Binding var selectedDriver: String
    
    let numberOfStops: Int
    let drivers: [String]
    let stopIconName: String = "mappin.and.ellipse"
    let driverIconName: String = "eye"
    let roundedRectangleCornerRadius: CGFloat = 10
    let shadowRadius: CGFloat = 5
    let fixedHorizontalSize : Bool = false
    let fixedVerticalSize : Bool = true
    let oneSidedPadding : CGFloat = 8
    
    // Computed property to provide a default value for `selectedDriver`
    var defaultSelectedDriver: String {
        drivers.first ?? "All Drivers"
    }
    
    var stopsCount: String {
        "\(numberOfStops) stops"
    }
    
    
    var body: some View {
        HStack {
            // Left element
            HStack {
                Image(systemName: stopIconName)
                Text(stopsCount)
            }
            .padding([.top, .bottom, .leading])
            .padding(.trailing, oneSidedPadding)
            
            Divider()
            
            // Centered Menu
            Menu {
                ForEach(drivers, id: \.self) { option in
                    Button(action: {
                        selectedDriver = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                Label(selectedDriver, systemImage: driverIconName)
            }
            .padding([.top, .bottom, .trailing])
            .padding(.leading, oneSidedPadding)
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: roundedRectangleCornerRadius)
                .fill(Color.white)
                .shadow(radius: shadowRadius)
        )
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: fixedHorizontalSize, vertical: fixedVerticalSize)
    }
}
