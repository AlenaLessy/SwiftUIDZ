//
//  LineGradient+extension.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 31.01.2023.
//

import SwiftUI

/// LinearGradient
extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
