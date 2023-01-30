//
//  NeumorphismSelected.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 30.01.2023.
//

import SwiftUI

/// Неоморфизм нажатая кнопка
struct NeumorphismSelected: ViewModifier {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let lightShadowColorName = "LightShadow"
        static let darkShadowColorName = "DarkShadow"
    }
    
    // MARK: - Public Methods
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(Constants.lightShadowColorName), radius: 5, x: 5, y: 5)
            .shadow(color: Color(Constants.darkShadowColorName), radius: 5, x: -5, y: -5)
    }
}
