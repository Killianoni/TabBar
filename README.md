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
            TabBarItem(icon: "house", label: "Home") {
                HomeView()
            }
            TabBarItem(icon: "magnifyingglass", label: "Search") {
                SearchView()
            }
            TabBarItem(icon: "person", label: "Profile") {
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
    TabBarItem(icon: "house", label: "Home") {
        HomeView()
    }
    TabBarItem(icon: "magnifyingglass", label: "Search") {
        SearchView()
    }
    TabBarItem(icon: "person", label: "Profile") {
        ProfileView()
    }
}
.withTabBarStyle(CustomTabStyle())
.withTabItemStyle(CustomItemStyle())
```

## Exemples
### Blur
<img width="425" alt="Capture d’écran 2025-03-17 à 16 43 33" src="https://github.com/user-attachments/assets/56870382-d81b-423a-8abc-0f5fde5508ff" />

### Transparent
<img width="424" alt="Capture d’écran 2025-03-17 à 16 43 45" src="https://github.com/user-attachments/assets/ba9c75cf-eebf-42fb-8a2c-edf6402a6253" />

### Plain
<img width="428" alt="Capture d’écran 2025-03-17 à 16 43 57" src="https://github.com/user-attachments/assets/34df13f2-44e2-46e1-9399-4b52c6098ab4" />

### Floating
<img width="426" alt="Capture d’écran 2025-03-17 à 16 44 10" src="https://github.com/user-attachments/assets/9126b890-bb14-4fb8-b5f6-f250aaad1aa0" />

You can also change the icons color/size and spacing

The only limit is your imagination
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
