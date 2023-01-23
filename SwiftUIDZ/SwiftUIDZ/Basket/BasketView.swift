//
//  BasketView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 22.01.2023.
//

import SwiftUI

/// Корзина покупок
struct BasketView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let selectedRateText = "Выбранный тариф:"
        static let buyButtonTitleText = "Купить"
        static let alertTitleText = "Подтвердить покупку?"
        static let alertOkButtonTitleText = "Ok"
        static let zeroBadgeNumber = 0
        static let spacingVStack: CGFloat = 50
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack(spacing: Constants.spacingVStack) {
            selectedRateTextView
            descriptionTextView
            buyButtonView
        }
    }
    
    // MARK: - Private Properties
    
    @EnvironmentObject private var ratesViewModel: RatesViewModel
    
    private var selectedRateTextView: Text {
        return Text(Constants.selectedRateText)
            .font(.largeTitle)
    }
    
    private var descriptionTextView: Text {
        return Text(ratesViewModel.getSelectedRateDescription())
            .font(.title)
    }
    
    private var buyButtonView: some View {
        return Button(Constants.buyButtonTitleText, action: {
            ratesViewModel.isPurchasePaymentButtonPressed = true
        })
        .alert(isPresented: $ratesViewModel.isPurchasePaymentButtonPressed) {
            Alert(title: Text(Constants.alertTitleText), primaryButton: .default(Text(Constants.alertOkButtonTitleText), action: {
                ratesViewModel.currentDaysOfSubscriptionNumber += ratesViewModel.daysOfSubscriptionNumber
                ratesViewModel.badge = Constants.zeroBadgeNumber
            }), secondaryButton: .cancel())
        }
    }
}
