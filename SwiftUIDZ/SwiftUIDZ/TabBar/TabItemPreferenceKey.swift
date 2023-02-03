//
//  TabItemPreferenceKey.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import SwiftUI

/// PreferenceKey для таббара
struct TabItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabItem] = []
    
    static func reduce(value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue()
    }
}
