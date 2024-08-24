# maps-with-stops-swift-swiftui

This SwiftUI project includes a map view integrated with a list of stops and drivers. It allows users to view and manage stops on a map, select drivers, and access detailed information about each stop.

## Features

- **Map View with Stops**: Displays stops on a map with custom markers and allows interaction.
- **Stop Details Sheet**: Provides detailed information about each stop when selected.
- **Driver Selector**: Allows users to select and filter stops by drivers.
- **Dynamic Reordering**: Enables reordering of stops and updating their positions.

## Components

### MapWithStopsView

The main view that integrates the map view and the driver selector. It manages state for the map and stop lists.

- **State Objects**:
  - `stopListViewModel`: Manages the list of stops.
  - `mapViewModel`: Manages the map's state and position.
  - `driverListViewModel`: Manages the list of drivers.

### StopMapView

Displays stops on the map and handles user interactions with markers.

- **Properties**:
  - `position`: The map's camera position.
  - `stops`: The list of stops to display.
  - `markerColor`: Color of the stop markers.
  - `distance`: The distance for the map's camera.
  - `animationDuration`: Duration for animations.
  - `selectedStop`: The currently selected stop.
  - `showSheet`: Controls the presentation of the stop details sheet.

### StopInfoView

Shows detailed information about a selected stop, including address, order, and driver information.

- **Bindings**:
  - `stop`: The selected stop to display.
  - `showSheet`: Controls the presentation of the view.
  - `viewModel`: The view model managing stop data.

### DriverSelectorView

Provides a UI for selecting drivers and displaying the number of stops.

- **Bindings**:
  - `selectedDriver`: The currently selected driver.
  - `numberOfStops`: The total number of stops.
  - `drivers`: The list of available drivers.

## Installation

1. Clone the repository:

    ```bash
    git clone <repository-url>
    ```

2. Open the project in Xcode:

    ```bash
    open <project-name>.xcodeproj
    ```

3. Build and run the project on a simulator or device.

## Usage

- Launch the app to see the map view with stops.
- Select a stop on the map to view details in a sheet.
- Use the driver selector to filter stops by driver.
- Reorder stops using the picker in the stop details view.

## Contributing

Feel free to submit issues or pull requests if you find bugs or want to add features.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
