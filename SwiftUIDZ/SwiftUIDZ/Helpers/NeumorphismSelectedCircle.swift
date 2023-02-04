// NeumorphismSelectedCircle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Неоморфизм нажатая кнопка
struct NeumorphismSelectedCircle: ViewModifier {
    // MARK: - Private Constants

    private enum Constants {
        static let backgroundColorName = "back2"
    }

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color(Constants.backgroundColorName)))
            .neumorphismUnSelectedStyle()
    }
}
