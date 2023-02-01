//
//  View+extension.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 30.01.2023.
//

import SwiftUI

/// Нейроморфизм стили
extension View {
    func neumorphismUnSelectedStyle() -> some View {
        modifier(NeumorphismUnSelected())
    }
    
    func neumorphismSelectedStyle() -> some View {
        modifier(NeumorphismSelected())
    }
    
    func neumorphismSelectedCircleStyle() -> some View {
        modifier(NeumorphismSelectedCircle())
    }
}

/// Анимация перехода между градиентами разных цветов
extension View {
    func animatableGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
    }
}
