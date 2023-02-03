//
//  TabBarShape.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import SwiftUI

/// Фигура для таб бара
struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 804))
        path.addLine(to: CGPoint(x: 16.47, y: 786.94))
        path.addCurve(
            to: CGPoint(x: 47.03, y: 774),
            control1: CGPoint(x: 24.46, y: 778.67),
            control2: CGPoint(x: 35.49, y: 774)
        )
        path.addLine(to: CGPoint(x: 125.28, y: 774))
        path.addCurve(
            to: CGPoint(x: 149.45, y: 781.52),
            control1: CGPoint(x: 133.93, y: 774),
            control2: CGPoint(x: 142.36, y: 776.62)
        )
        path.addLine(to: CGPoint(x: 170.6, y: 796.12))
        path.addCurve(
            to: CGPoint(x: 222.4, y: 796.12),
            control1: CGPoint(x: 186.17, y: 806.87),
            control2: CGPoint(x: 206.83, y: 806.87)
        )
        path.addLine(to: CGPoint(x: 243.55, y: 781.52))
        path.addCurve(
            to: CGPoint(x: 267.72, y: 774),
            control1: CGPoint(x: 250.64, y: 776.62),
            control2: CGPoint(x: 259.07, y: 774)
        )
        path.addLine(to: CGPoint(x: 345.97, y: 774))
        path.addCurve(
            to: CGPoint(x: 376.53, y: 786.94),
            control1: CGPoint(x: 357.51, y: 774),
            control2: CGPoint(x: 368.54, y: 778.67)
        )
        path.addLine(to: CGPoint(x: 393, y: 804))
        path.addLine(to: CGPoint(x: 393, y: 852))
        path.addLine(to: CGPoint(x: 0, y: 852))
        path.addLine(to: CGPoint(x: 0, y: 804))
        return path
    }
}
