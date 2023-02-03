//
//  SplashScreenViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import SwiftUI

/// Вью модель загрузочного экрана
final class SplashScreenViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let gradientColorOneName = "GradientBackgroundTop"
        static let gradientColorTwoName = "GradientBackGroundBottom"
        static let timeIntervalNumber = 0.25
        static let newPartProgressNumber = 0.1
        static let maxRenderingProgressNumber = 3.0
       
    }

    // MARK: - Public Properties

    @Published var backgroundColors = [Color(Constants.gradientColorOneName), Color(Constants.gradientColorTwoName)]
    @Published var renderingProgress = 0.0
    @Published var isActivateToWelcomeView = false
    @Published var isFillLogo = false
    
    // MARK: - Public Methods

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: Constants.timeIntervalNumber, repeats: true) { timer in
            if self.renderingProgress >= Constants.maxRenderingProgressNumber {
                timer.invalidate()
            }
            withAnimation(.linear(duration: 1)) {
                self.renderingProgress += Constants.newPartProgressNumber
            }
        }
    }
}
