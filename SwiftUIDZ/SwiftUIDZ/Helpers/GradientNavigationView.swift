//
//  GradientNavigationView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Градиент Навигейшена
struct GradientNavigationView: View {
    
    // MARK: - Public Properties
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(
                colors: [.yellow.opacity(1),
                         .red.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
    }
}
