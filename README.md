# TabBar

A fully customizable TabBar component for SwiftUI applications.

## Overview

`TabBar` is a Swift package that provides a customizable tab bar for SwiftUI applications. It allows developers to create a tabbed interface with ease, offering flexibility in design and functionality.

## Features

- Fully customizable appearance
- Easy integration with SwiftUI projects
- Supports multiple tabs with custom icons and labels
- Dark mode support
- Adaptive layout for different screen sizes

## Installation

To integrate `TabBar` into your SwiftUI project, follow these steps:

### Using Swift Package Manager:

1. Open your project in Xcode.
2. Navigate to `File` > `Add Packages...`.
3. Enter the repository URL: `https://github.com/Killianoni/TabBar`.
4. Select the desired version and add the package to your project.

## Usage

Here's a basic example of how to use `TabBar` in your SwiftUI application:

```swift
import SwiftUI
import TabBar

struct ContentView: View {
    var body: some View {
        TabBarView {
            TabBarItem(icon: Image(systemName: "house"), label: Text("Home")) {
                HomeView()
            }
            TabBarItem(icon: Image(systemName: "magnifyingglass"), label: Text("Search")) {
                SearchView()
            }
            TabBarItem(icon: Image(systemName: "person"), label: Text("Profile")) {
                ProfileView()
            }
        }
    }
}
```

## Customization

### Changing TabBar Appearance

You can customize the TabBar appearance using modifiers:

```swift
private struct CustomTabStyle: TabBarStyle {
    func makeTabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .padding()
            .frame(maxWidth: .infinity)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
    }
}
```

### Custom Tab Items

Each `TabBarItem` can be styled individually:

```swift
private struct CustomItemStyle: TabItemStyle {
    func makeTabItem(icon: String, title: String, isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(isSelected ? .blue : .gray)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.caption)
                .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}
```

### Apply to Tabbar

Enable smooth animations between tabs:

```swift
TabBarView {
    TabBarItem(icon: Image(systemName: "house"), label: Text("Home")) {
        HomeView()
    }
    TabBarItem(icon: Image(systemName: "magnifyingglass"), label: Text("Search")) {
        SearchView()
    }
    TabBarItem(icon: Image(systemName: "person"), label: Text("Profile")) {
        ProfileView()
    }
}
.withTabBarStyle(CustomTabStyle())
.withTabItemStyle(CustomItemStyle())
```

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/YourFeature`.
3. Commit your changes: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature/YourFeature`.
5. Open a pull request.

Please ensure your code adheres to the project's coding standards and includes appropriate tests.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](./LICENSE) file for details.
