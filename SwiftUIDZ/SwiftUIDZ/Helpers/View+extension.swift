//
//  View+extension.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import SwiftUI

/// Модификатор закругления 1 угла
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
