//
//  GradientBackgroundStackView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 31.01.2023.
//

import SwiftUI

/// Бекграунд с  2 градиентами
struct GradientsBackgroundStackView: View {
    
    // MARK: - Public Properties
    
    let fromGradientColors: [Color]
    let toGradientColors: [Color]
    let progress: CGFloat
    
    // MARK: - Public Methods
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animatableGradient(fromGradient: Gradient(colors: fromGradientColors), toGradient: Gradient(colors: toGradientColors), progress: progress)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
