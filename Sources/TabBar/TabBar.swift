//
//  Tabbar.swift
//  FreeMyCals
//
//  Created by KILLIAN ADONAI on 14/03/2025.
//

import SwiftUI

public protocol TabItemStyle {
    associatedtype Body: View
    func makeTabItem(icon: String, title: String, isSelected: Bool) -> Self.Body
}

public protocol TabBarStyle {
    associatedtype Body: View
    func makeTabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> Self.Body
}

public struct AnyTabItemStyle: TabItemStyle {
    private let _makeTabItem: (String, String, Bool) -> AnyView

    public init<S: TabItemStyle>(_ style: S) {
        self._makeTabItem = { icon, title, isSelected in
            AnyView(style.makeTabItem(icon: icon, title: title, isSelected: isSelected))
        }
    }

    public func makeTabItem(icon: String, title: String, isSelected: Bool) -> some View {
        _makeTabItem(icon, title, isSelected)
    }
}

public struct AnyTabBarStyle: TabBarStyle {
    private let _makeTabBar: (GeometryProxy, @escaping () -> AnyView) -> AnyView

    public init<S: TabBarStyle>(_ style: S) {
        self._makeTabBar = { geometry, itemsContainer in
            AnyView(style.makeTabBar(with: geometry, itemsContainer: itemsContainer))
        }
    }

    public func makeTabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        _makeTabBar(geometry, itemsContainer)
    }
}

public struct TabItemData {
    public let content: AnyView
    public let icon: String
    public let title: String

    public init<Content: View>(content: Content, icon: String, title: String) {
        self.content = AnyView(content)
        self.icon = icon
        self.title = title
    }
}

@resultBuilder
public struct TabItemBuilder {
    public static func buildBlock(_ items: TabItemData...) -> [TabItemData] {
        items
    }
}

public func TabBarItem<Content: View>(
    icon: String,
    title: String,
    @ViewBuilder content: () -> Content
) -> TabItemData {
    TabItemData(content: content(), icon: icon, title: title)
}

public struct TabBar: View {
    @State private var selectedIndex: Int = 0
    private let items: [TabItemData]
    private var tabBarStyle: AnyTabBarStyle
    private var tabItemStyle: AnyTabItemStyle
    public let itemSpacing: CGFloat

    public init(itemSpacing: CGFloat = 60, @TabItemBuilder items: () -> [TabItemData]) {
        self.itemSpacing = itemSpacing
        self.items = items()
        self.tabBarStyle = AnyTabBarStyle(DefaultTabBarStyle())
        self.tabItemStyle = AnyTabItemStyle(DefaultTabItemStyle())
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            if items.indices.contains(selectedIndex) {
                items[selectedIndex].content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }

            GeometryReader { geometry in
                tabBarStyle.makeTabBar(with: geometry) {
                    AnyView(
                        HStack(spacing: itemSpacing) {
                            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                                Button(action: {
                                    withAnimation { selectedIndex = index }
                                }) {
                                    tabItemStyle.makeTabItem(icon: item.icon,
                                                             title: item.title,
                                                             isSelected: selectedIndex == index)
                                }
                            }
                        }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
            }
            .frame(maxHeight: 60)
        }
    }

    public func withTabBarStyle<S: TabBarStyle>(_ style: S) -> TabBar {
        var copy = self
        copy.tabBarStyle = AnyTabBarStyle(style)
        return copy
    }

    public func withTabItemStyle<S: TabItemStyle>(_ style: S) -> TabBar {
        var copy = self
        copy.tabItemStyle = AnyTabItemStyle(style)
        return copy
    }
}

// MARK: - Styles
public struct DefaultTabItemStyle: TabItemStyle {
    public init() {}
    public func makeTabItem(icon: String, title: String, isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(isSelected ? .blue : .gray)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.caption)
                .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}

public struct DefaultTabBarStyle: TabBarStyle {
    public init() {}
    public func makeTabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .padding(.bottom, geometry.safeAreaInsets.bottom)
    }
}

public struct TransparentTabBarStyle: TabBarStyle {
    public init() {}
    public func makeTabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .padding(.bottom, geometry.safeAreaInsets.bottom)
    }
}

public struct FloatingTabBarStyle: TabBarStyle {
    public init() {}
    public func makeTabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .padding()
            .background(Color.green.opacity(0.6))
            .cornerRadius(18)
            .frame(width: 300, height: 60)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
    }
}

public struct PlainTabBarStyle: TabBarStyle {
    public init() {}
    public func makeTabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .padding()
            .frame(maxWidth: .infinity)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
            .background(Color.white)
    }
}
