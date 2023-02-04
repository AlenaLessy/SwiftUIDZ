// BackgroundStackView.swift
// Copyright © RoadMap. All rights reserved.

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
