// ChargingViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class ChargingViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var changeSliderValue = 65.0
    
    // MARK: - Public Methods
    
    func getChargingValue() -> Int {
        Int(changeSliderValue)
    }
    
    func getChargeProcess() -> Double {
        changeSliderValue / 100
    }
}
