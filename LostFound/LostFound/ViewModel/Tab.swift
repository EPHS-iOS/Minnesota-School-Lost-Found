//
//  Tab.swift
//  LostFound
//
//  Created by 90305906 on 5/18/22.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .home, color: .teal),
    TabItem(text: "Explore", icon: "magnifyingglass", tab: .explore, color: .blue),
    TabItem(text: "Profile", icon: "person", tab: .user, color: .pink),
    //TabItem(text: "Library", icon: "rectangle.stack", tab: .library, color: .red)
]

enum Tab: String {
    case home
    case explore
    case user
    case library
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
