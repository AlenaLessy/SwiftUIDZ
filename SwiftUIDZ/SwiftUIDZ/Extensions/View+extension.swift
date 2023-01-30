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
