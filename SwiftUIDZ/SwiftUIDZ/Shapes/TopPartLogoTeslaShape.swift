//
//  TopPartLogoTeslaShape.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import SwiftUI

/// Верхняя часть логотипа теслы
struct TopPartLogoTeslaShape: Shape {
func path(in rect: CGRect) -> Path {
var path = Path()
path.move(to: CGPoint(x: 0, y: 33.29))
path.addCurve(
    to: CGPoint(x: 170, y: 0),
    control1: CGPoint(x: 61.95, y: 8.64),
    control2: CGPoint(x: 120.03, y: 0.19)
)
path.addCurve(
    to: CGPoint(x: 340, y: 33.29),
    control1: CGPoint(x: 219.97, y: 0.19),
    control2: CGPoint(x: 277.95, y: 8.64)
)
path.addQuadCurve(
    to: CGPoint(x: 330.43, y: 52.99),
    control: CGPoint(x: 337.97, y: 39.31)
)
path.addCurve(
    to: CGPoint(x: 170, y: 20.67),
    control1: CGPoint(x: 273.8, y: 28.15),
    control2: CGPoint(x: 218.42, y: 20.29)
)
path.addCurve(
    to: CGPoint(x: 9.47, y: 52.99),
    control1: CGPoint(x: 121.58, y: 20.29),
    control2: CGPoint(x: 66.2, y: 28.24)
)
path.addQuadCurve(
    to: CGPoint(x: 0, y: 33.39),
    control: CGPoint(x: 2.8, y: 40.77)
)
path.closeSubpath()
return path
}
}
