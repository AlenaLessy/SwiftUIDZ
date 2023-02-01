// SettingsClimateModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель настройки климата
struct SettingsClimateModel {
    /// Название настройки
    let settingName: String
    /// Название картинки на иконку кнопки
    let settingsImageName: String
    /// Максимальное значение слайдера
    let sliderMaxValue: Double
    /// Активность настройки
    var isAction: Bool

    static func getSettings() -> [SettingsClimateModel] {
        [
            SettingsClimateModel(
                settingName: "As",
                settingsImageName: "snowflake",
                sliderMaxValue: 15,
                isAction: false
            ),
            SettingsClimateModel(settingName: "Fan", settingsImageName: "wind", sliderMaxValue: 15, isAction: false),
            SettingsClimateModel(
                settingName: "Heat",
                settingsImageName: "humidity.fill",
                sliderMaxValue: 15,
                isAction: false
            ),
            SettingsClimateModel(settingName: "Auto", settingsImageName: "timer", sliderMaxValue: 15, isAction: false)
        ]
    }
}
