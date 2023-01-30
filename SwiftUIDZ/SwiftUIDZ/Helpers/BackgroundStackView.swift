//
//  BackgroundStackView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 30.01.2023.
//
import SwiftUI

/// Бекграунд с цветом фона приложения
struct BackgroundStackView<Content: View>: View {
    
    // MARK: - Public Properties
    
    let content: () -> Content
 
    // MARK: - Public Methods
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Background"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}
