import SwiftUI

struct DropdownSelectorView: View {
    @State private var selectedOption: String = "Select a driver"
    
    let options: [String] = ["Bronelys", "Miguel"]

    var body: some View {
        VStack {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "arrow.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            }
        }
        .padding()
    }
}
