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
        static let lightShadowColorName = "ligth"
        static let darkShadowColorName = "dark"
        
    }
    
    // MARK: - Public Methods
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color(Constants.lightShadowColorName).opacity(0.25), radius: 6, x: 6, y: 6)
            .shadow(color: Color(Constants.darkShadowColorName).opacity(0.25), radius: 6, x: -6, y: -6)
    }
}
