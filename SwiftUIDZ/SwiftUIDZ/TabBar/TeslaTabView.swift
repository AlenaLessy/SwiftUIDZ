// TeslaTabView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Изогнутый таб бар для приложения теслы
struct TeslaTabView<Content: View>: View {

    // MARK: - Public Property
    
    var body: some View {
        tabBarStackView
            .ignoresSafeArea()
    }
    
    // MARK: - Private Property
    
    private let content: Content
    
    @Binding private var selection: Int
    @Binding private var isTabBarShown: Bool
    
    @State private var tabs: [TabItem] = []
    
    @Namespace private var tabBarItem
    
    private var tabsView: some View {
        ForEach(Array(tabs.enumerated()), id: \.offset) { index, element in
            VStack {
                Image(systemName: element.icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(selection == index ? Color("GradientBackgroundTop") : .white)
            }
            .background {
                ZStack {
                    if selection == index {
                        Circle()
                            .fill(gradient.opacity(0.3))
                            .frame(width: 70, height: 70)
                            .blur(radius: 8)
                            .matchedGeometryEffect(id: "tabBarItem", in: tabBarItem)
                    }
                }
            }
            .onTapGesture {
                withAnimation {
                    selection = index
                }
            }
        }
    }
    
    private var tabBarStackView: some View {
        ZStack(alignment: .bottom) {
            content
            if isTabBarShown {
                TabBarShape()
                    .fill(Color("back2"))
                    .background {
                        TabBarShape()
                            .neumorphismSelectedStyle()
                    }
                HStack(spacing: 65) {
                    tabsView
                }
                .padding(.bottom, 16)
            }
        }
        .onPreferenceChange(TabItemPreferenceKey.self) { value in
            tabs = value
        }
    }
    
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [Color("GradientTop"), Color("GradientBottom")],
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    // MARK: - Initializers
    
    init(selection: Binding<Int>, showTabBar: Binding<Bool>, @ViewBuilder content: () -> Content) {
        _selection = selection
        _isTabBarShown = showTabBar
        self.content = content()
    }
}
