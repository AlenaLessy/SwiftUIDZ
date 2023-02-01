// LineGradient+extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// LinearGradient
extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
