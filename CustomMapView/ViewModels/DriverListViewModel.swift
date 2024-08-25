import SwiftUI

/// A view model responsible for managing the list of drivers.
class DriverListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// The list of drivers available for selection.
    @Published var drivers: [String] = ["All Drivers", "Bronelys", "Miguel"]
    @Published var role: String = "admin"
    // MARK: - Methods

    /// Adds a new driver to the list.
    /// - Parameter driver: The name of the driver to be added.
    func addDriver(_ driver: String) {
        guard !driver.isEmpty, !drivers.contains(driver) else { return }
        drivers.append(driver)
    }
    
    /// Removes a driver from the list.
    /// - Parameter driver: The name of the driver to be removed.
    func removeDriver(_ driver: String) {
        drivers.removeAll { $0 == driver }
    }
    
    /// Updates the name of an existing driver.
    /// - Parameters:
    ///   - oldName: The current name of the driver.
    ///   - newName: The new name of the driver.
    func updateDriverName(from oldName: String, to newName: String) {
        guard !newName.isEmpty, drivers.contains(oldName) else { return }
        if let index = drivers.firstIndex(of: oldName) {
            drivers[index] = newName
        }
    }
}
