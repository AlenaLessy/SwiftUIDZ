// TabItemPreferenceKey.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// PreferenceKey для таббара
struct TabItemPreferenceKey: PreferenceKey {
    
    // MARK: - Public Property
    static var defaultValue: [TabItem] = []
    
    //MARK: - Public Method
    
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}
