//
//  RatesViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 22.01.2023.
//

import SwiftUI

/// Вью-модель экрана тарифов
final class RatesViewModel: ObservableObject {
    
    // MARK: - Private Constants
    private enum Constants {
        static let oneDaysSubscriptionText = "Vacation (1 day) 19 RUB"
        static let oneMonthSubscriptionText = "Standart (1 month) 179 RUB"
        static let oneYearSubscriptionText = "Super (1 year) 1599 RUB"
        static let defaultSubscriptionText = "Тариф не выбран"
        static let zeroNumber = 0
        static let currentDaysOfSubscriptionNumber = 15
        static let oneDayNumber = 1
        static let oneMonthNumber = 30
        static let oneYearNumber = 365
    }
    
    // MARK: - Public Properties
    
    @Published var daysOfSubscriptionNumber = Constants.zeroNumber
    @Published var badge = Constants.zeroNumber
    @Published var currentDaysOfSubscriptionNumber = Constants.currentDaysOfSubscriptionNumber
    @Published var isPurchasePaymentButtonPressed = false
    
    // MARK: - Public Methods
    
    func getSelectedRateDescription() -> String {
        switch daysOfSubscriptionNumber {
        case Constants.oneDayNumber:
            return Constants.oneDaysSubscriptionText
        case Constants.oneMonthNumber:
            return Constants.oneMonthSubscriptionText
        case Constants.oneYearNumber:
            return Constants.oneYearSubscriptionText
        default:
            return Constants.defaultSubscriptionText
        }
    }
    
    func getDaysOfSubscriptionNumber() -> Int {
        currentDaysOfSubscriptionNumber
    }
}
