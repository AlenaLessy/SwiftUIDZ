// BackgroundStackView.swift
// Copyright © RoadMap. All rights reserved.

//
//  BackgroundStackView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 30.01.2023.
//
import SwiftUI

/// Бекграунд экрана c 1 градиентом
struct BackgroundStackView<Content: View>: View {
    // MARK: - Public Properties

    let colors: [Color]
    let content: () -> Content

    // MARK: - Public Methods

    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}
