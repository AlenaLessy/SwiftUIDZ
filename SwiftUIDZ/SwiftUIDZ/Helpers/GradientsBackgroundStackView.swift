//
//  GradientBackgroundStackView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 31.01.2023.
//

import SwiftUI

/// Бекграунд с градиентами
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


//struct GradientBackgroundStackView<Content: View>: View {
//
//    // MARK: - Public Properties
//
//    let colors: [Color]
//   // let content: () -> Content
//
//    // MARK: - Public Methods
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(gradient)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .edgesIgnoringSafeArea(.all)
////             content()
//        }
//    }
//
//    private var gradient: LinearGradient {
//        LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
//    }
//}
