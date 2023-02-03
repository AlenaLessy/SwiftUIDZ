// NeumorphismSelected.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Модификатор для добавления TabItem
struct TabItemModifier: ViewModifier {
    let tabBarItem: TabItem
    
    func body(content: Content) -> some View {
        content
            .preference(key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}
