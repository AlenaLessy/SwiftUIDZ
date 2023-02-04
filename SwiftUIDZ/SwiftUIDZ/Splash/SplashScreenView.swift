// SplashScreenView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Загрузочный экран
struct SplashScreenView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let backgroundColorViewName = "back2"
        static let colorChangeLogoViewTimeNumber = 3.5
        static let changeScreenTimeNumber = 4.3
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        if splashScreenViewModel.isActivateToWelcomeView {
            WelcomeView()
        } else {
            BackgroundStackView(colors: splashScreenViewModel.backgroundColors) {
                ZStack {
                    topPartLogoTeslaView
                    bottomPartLogoTeslaView
                }
                .padding(.horizontal, 25)
                .padding(.top, 190)
                .onAppear {
                    splashScreenViewModel.startTimer()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.colorChangeLogoViewTimeNumber) {
                        withAnimation {
                            splashScreenViewModel.isFillLogo.toggle()
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.3) {
                        withAnimation {
                            splashScreenViewModel.isActivateToWelcomeView.toggle()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Private Properties
    
    @StateObject private var splashScreenViewModel = SplashScreenViewModel()
    
    private var topPartLogoTeslaView: some View {
        TopPartLogoTeslaShape()
            .trim(from: 0, to: splashScreenViewModel.renderingProgress)
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .fill(splashScreenViewModel.isFillLogo ? Color(Constants.backgroundColorViewName) : .white)
            .neumorphismSelectedStyle()
    }
    
    private var bottomPartLogoTeslaView: some View {
        BottomPartLogoTeslaShape()
            .trim(from: 0, to: splashScreenViewModel.renderingProgress)
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .fill(splashScreenViewModel.isFillLogo ? Color(Constants.backgroundColorViewName) : .white)
            .neumorphismSelectedStyle()
    }
}
    
    struct TeslaLogoView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
                .environment(\.colorScheme, .dark)
        }
    }
