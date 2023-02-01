// NeumorphismUnSelected.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Неоморфизм отпущенная кнопка
struct NeumorphismUnSelected: ViewModifier {
    // MARK: - Private Constants

    private enum Constants {
        static let lightShadowColorName = "ligth"
        static let darkShadowColorName = "dark"
    }

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .shadow(color: Color(Constants.lightShadowColorName).opacity(0.1), radius: 10, x: -6, y: -6)
            .shadow(color: Color(Constants.darkShadowColorName).opacity(0.5), radius: 10, x: 6, y: 6)
    }
}
