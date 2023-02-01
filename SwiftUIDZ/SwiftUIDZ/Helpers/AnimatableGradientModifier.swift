// AnimatableGradientModifier.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Анимирование градиентов
struct AnimatableGradientModifier: AnimatableModifier {
    // MARK: - Public Properties

    let fromGradient: Gradient
    let toGradient: Gradient

    var progress: CGFloat = 0.0

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        var gradientColors: [Color] = []
        for index in 0 ..< fromGradient.stops.count {
            let fromColor = UIColor(fromGradient.stops[index].color)
            let toColor = UIColor(toGradient.stops[index].color)
            gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
        }
        return LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom)
    }

    // MARK: - Private Methods

    private func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
        guard let toColor = toColor.cgColor.components else { return Color(toColor) }
        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
}
