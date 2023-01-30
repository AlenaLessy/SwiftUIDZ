//
//  NeumorphismSelectedCircle.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 30.01.2023.
//

import SwiftUI

/// Неоморфизм нажатая кнопка
struct NeumorphismSelectedCircle: ViewModifier {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let backgroundColorName = "Background"
    }
    
    // MARK: - Public Methods
    
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(Circle().fill(Color(Constants.backgroundColorName)))
            .neumorphismUnSelectedStyle()
    }
}
