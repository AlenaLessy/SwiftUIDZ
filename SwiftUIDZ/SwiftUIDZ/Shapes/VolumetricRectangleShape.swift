// VolumetricRectangleShape.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Объемный приплюснутый прямоугольник
struct VolumetricRectangleShape: Shape {
    // MARK: - Public Property
    
    var figureWidth: CGFloat
    
    // MARK: - Public Method
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY - 15))
        path.addLine(to: CGPoint(x: 15, y: rect.maxY - 49))
        path.addLine(to: CGPoint(x: rect.maxX * figureWidth - 15, y: rect.maxY - 49))
        path.addLine(to: CGPoint(x: rect.maxX * figureWidth, y: rect.maxY - 15))
        path.addLine(to: CGPoint(x: rect.maxX * figureWidth, y: rect.maxY))
        return path
    }
}
