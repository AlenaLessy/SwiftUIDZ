// ClimateControlViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью - модель настроек системы кондиционирования
final class ClimateControlViewModel: ObservableObject {
    // MARK: - Private Constants

    private enum Constants {
        static let gradientColorOneName = "GradientBackgroundTop"
        static let gradientColorTwoName = "GradientBackGroundBottom"
        static let maxCountSteperNumber = 15
        static let spacingForFixedBottomSheetNumber: CGFloat = 170
        static let displayDistanceBottomSheetNumber: CGFloat = -160
    }

    // MARK: - Public Properties

    @Published var gradientColors = [Color(Constants.gradientColorOneName), Color(Constants.gradientColorTwoName)]
    @Published var settingsIndex = 0
    @Published var steperCurrentValue = 0
    @Published var isSettingsButtonPressed = false
    @Published var settingsClimate = SettingsClimateModel.getSettings()
    @Published var climateSliderValues = [0.0, 0.0, 0.0, 0.0]
    @Published var isClimateControlEnabled = false
    @Published var bottomSheetCurrentOffsetY: CGFloat = 0
    @Published var bottomSheetLastOffsetY: CGFloat = 0
    @Published var topGradientColor: CGColor = .init(red: 00, green: 15, blue: 09, alpha: 1)
    @Published var bottomGradientColor: CGColor = .init(red: 00, green: 00, blue: 21, alpha: 1)

    // MARK: - Public Methods

    func getTemperature() -> Int {
        var result = 0.0
        for index in 0 ..< climateSliderValues.count {
            result += climateSliderValues[index]
        }
        result += Double(steperCurrentValue)
        return Int(result)
    }

    func steperIncrement() {
        guard steperCurrentValue < Constants.maxCountSteperNumber,
              isClimateControlEnabled
        else { return }
        steperCurrentValue += 1
    }

    func steperDecrement() {
        guard steperCurrentValue > 0,
              isClimateControlEnabled
        else { return }
        steperCurrentValue -= 1
    }

    func isActive() {
        if !settingsClimate[settingsIndex].isAction {
            climateSliderValues[settingsIndex] = 0
        }
    }

    func bottomSheetOffsetY() {
        if -bottomSheetCurrentOffsetY > Constants.spacingForFixedBottomSheetNumber {
            bottomSheetCurrentOffsetY = Constants.displayDistanceBottomSheetNumber
        } else {
            bottomSheetCurrentOffsetY = 0
        }
        bottomSheetLastOffsetY = bottomSheetCurrentOffsetY
    }

    func onChangeBottomSheetOffset(gestureOffsetValue: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.bottomSheetCurrentOffsetY = gestureOffsetValue + self.bottomSheetLastOffsetY
        }
    }
}
