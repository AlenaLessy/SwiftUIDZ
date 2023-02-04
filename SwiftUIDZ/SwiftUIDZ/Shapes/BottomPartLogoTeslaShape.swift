// BottomPartLogoTeslaShape.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Нижняя часть логотипа теслы
struct BottomPartLogoTeslaShape: Shape {
    
    // MARK: - Public Methods
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 14.79, y: 62.12))
        path.addQuadCurve(
            to: CGPoint(x: 134.82, y: 33),
            control: CGPoint(x: 74.71, y: 34.26)
        )
        path.addLine(to: CGPoint(x: 169.81, y: 75.9))
        path.addLine(to: CGPoint(x: 204.89, y: 33))
        path.addQuadCurve(
            to: CGPoint(x: 324.92, y: 62.12),
            control: CGPoint(x: 265.1, y: 34.26)
        )
        path.addQuadCurve(
            to: CGPoint(x: 279.21, y: 99.67),
            control: CGPoint(x: 309.65, y: 85.32)
        )
        path.addCurve(
            to: CGPoint(x: 217.55, y: 71.34),
            control1: CGPoint(x: 277.18, y: 76.29),
            control2: CGPoint(x: 262.88, y: 71.34)
        )
        path.addLine(to: CGPoint(x: 170, y: 340))
        path.addLine(to: CGPoint(x: 121.87, y: 71.24))
        path.addCurve(
            to: CGPoint(x: 60.5, y: 96.67),
            control1: CGPoint(x: 76.83, y: 71.34),
            control2: CGPoint(x: 62.53, y: 76.29)
        )
        path.addQuadCurve(
            to: CGPoint(x: 14.79, y: 62.12),
            control: CGPoint(x: 30.15, y: 85.22)
        )
        path.closeSubpath()
        return path
    }
}
