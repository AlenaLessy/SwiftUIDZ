// WelcomeViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель экрана приветствия
final class WelcomeViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let openCarButtonTagNumber = 1
        static let closeText = "Закрыть"
        static let openText = "Открыть"
        static let lockOpenFillSystemImageName = "lock.open.fill"
        static let lockFillSystemImageName = "lock.fill"
        static let closeCarImageName = "image 46"
        static let openCarImageName = "image 47"
        static let startGradientProgressNumber: CGFloat = 0
        static let endGradientProgressNumber: CGFloat = 1
        static let lockGradientColorsOneName = "back11"
        static let lockGradientColorsTwoName = "back12"
        static let lockGradientColorsThreeName = "back13"
        static let lockGradientColorsFourName = "back14"
        static let unlockGradientColorsOneName = "GradientBackgroundTop"
        static let unlockGradientColorsTwoName = "GradientBackGroundBottom"
    }

    // MARK: - Public Properties

    @Published var buttonTagSelected = 0
    @Published var isChangeImage = false
    @Published var gradientProgress: CGFloat = 0
    @Published var isSettingsButtonPressed = false
    @Published var isLock = false
    @Published var lockGradientColors = [
        Color(Constants.lockGradientColorsOneName),
        Color(Constants.lockGradientColorsTwoName),
        Color(Constants.lockGradientColorsThreeName),
        Color(Constants.lockGradientColorsFourName)
    ]
    @Published var unlockGradientColors = [
        Color(Constants.unlockGradientColorsOneName),
        Color(Constants.unlockGradientColorsOneName),
        Color(Constants.unlockGradientColorsTwoName),
        Color(Constants.unlockGradientColorsTwoName)
    ]

    // MARK: - Public Methods

    func isOpenCarButtonPressed() -> Bool {
        if buttonTagSelected == Constants.openCarButtonTagNumber {
            return true
        } else {
            return false
        }
    }

    func getCarImageName() -> String {
        isChangeImage ? Constants.closeCarImageName : Constants.openCarImageName
    }

    func getLockTitleText() -> String {
        isChangeImage ? Constants.closeText : Constants.openText
    }

    func getLockIconName() -> String {
        isChangeImage ? Constants.lockOpenFillSystemImageName : Constants.lockFillSystemImageName
    }

    func gradientColor() {
        if isChangeImage {
            gradientProgress = Constants.startGradientProgressNumber
        } else {
            gradientProgress = Constants.endGradientProgressNumber
        }
    }
}
