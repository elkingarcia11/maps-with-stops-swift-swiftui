//
//  StopDetailView.swift
//  CustomMapView
//
//  Created by Elkin Garcia on 8/25/24.
//

import Foundation


import SwiftUI
import CoreLocation

struct StopDetailView: View {
    @Binding var stop: Stop
    @Binding var showSheet: Bool
    @ObservedObject var viewModel: StopListViewModel
    @State private var selectedIndex: Int
    var role : String
    
    @State var tempOrder : Int
    @State var tempDriver : String
    @State var isExpandedView : Bool = false
    @State var milesAway : CGFloat = 0.3
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
    var formattedMilesAway: String {
            String(format: "%.1f", milesAway) // Format to one decimal place
        }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12) // Set the corner radius
                .fill(Color("F3F4EC")) // Set the background color
                .shadow(radius: 1)
                .padding()
            VStack{
                HStack(alignment: .top){
                    VStack{
                        NumberInSFIconView(number: selectedIndex+1)
                    }
                    
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            Text(stop.sender.name)
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("A24029"))
                            Spacer()
                            Button(action: {
                                // Action to perform when button is tapped
                                print("Button tapped!")
                            }) {
                                Image(systemName: isExpandedView ? "chevron.up" : "chevron.down")
                                    .font(.title2)
                                    .foregroundStyle(Color("A24029"))
                            }
                        }
                        Text("\(stop.sender.address)")
                            .font(.footnote)
                        HStack{
                            Text("\(stop.sender.city), \(stop.sender.state) \(stop.sender.zip)")
                                .font(.footnote)
                            Spacer()
                            Label("\(formattedMilesAway) mi", systemImage: "mappin.and.ellipse")
                                .font(.footnote)
                        }
                        Button(stop.sender.phone){
                            
                        }
                        .foregroundStyle(Color("A24029"))
                        if isExpandedView {
                            Text("Current driver: \(stop.driver)")
                                .font(.footnote)
                                .foregroundStyle(Color(.darkGray))
                        }
                        
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        
    }
}

struct NumberInSFIconView: View {
    var number: Int
    var symbolName: String = "seal.fill" // Change this to use different SF Symbols
    var iconColor: Color = Color("54341C")
    var textColor: Color = .white
    var iconSize: CGFloat = 25
    
    var body: some View {
        ZStack {
            Image(systemName: symbolName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(iconColor)
                .frame(width: iconSize, height: iconSize)
            
            Text("\(number)")
                .font(.callout)
                .foregroundColor(textColor)
        }
    }
}

struct StopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample data for preview
        let sampleStop = Stop.default
        let sampleViewModel = StopListViewModel()
        let role = "user"
        sampleViewModel.drivers = ["Driver A", "Driver B", "Driver C"]
        
        return StopDetailView(stop: .constant(sampleStop), showSheet: .constant(true), viewModel: sampleViewModel, role: role)
    }
}
