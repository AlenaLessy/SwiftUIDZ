//
//  volumetricRectangleShape.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import SwiftUI

/// Объемный приплюснутый прямоугольник
struct VolumetricRectangleShape: Shape {
    // MARK: - Public Methods
    
    var figureWidth: CGFloat
    
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
