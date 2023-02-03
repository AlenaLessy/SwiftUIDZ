//
//  SettingsViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 30.01.2023.
//

import SwiftUI

/// Вью-модель экрана настроек
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let openCarButtonTagNumber = 1
        static let climateControlButtonTagNumber = 2
        static let teslaImageName = "tesla"
        static let openTeslaImageName = "opentesla"
        static let closeText = "Закрыть"
        static let openText = "Открыть"
        static let lockOpenFillSystemImageName = "lock.open.fill"
        static let lockFillSystemImageName = "lock.fill"
    }
    
    // MARK: - Public Properties
    
    @Published var buttonTagSelected = 0
    @Published var isCarClose = false
    @Published var isClimateControlViewDestination = false
    @Published var backgroundColors = [Color("back2")]
    
    
    // MARK: - Public Methods
    
    func isOpenCarButtonPressed() -> Bool {
        if buttonTagSelected == Constants.openCarButtonTagNumber {
            return true
        } else {
            return false
        }
    }
    
    func isClimateControlButtonPressed()  {
        if buttonTagSelected == Constants.climateControlButtonTagNumber {
            isClimateControlViewDestination = true
        }
    }
    
    func getTeslaOrOpenTeslaImageName() -> String {
       isCarClose ? Constants.openTeslaImageName : Constants.teslaImageName
    }
    
    func getCloseCarControlTitleText() -> String {
        isCarClose ? Constants.closeText : Constants.openText
    }
        
    func getCloseCarControlIconName() -> String {
        isCarClose ? Constants.lockOpenFillSystemImageName : Constants.lockFillSystemImageName
    }
}
