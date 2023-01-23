//
//  RatesView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 22.01.2023.
//

import SwiftUI

/// Экран тарифов
struct RatesView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let oneDaysSubscriptionText = "Vacation (1 day) 19 RUB"
        static let oneMonthSubscriptionText = "Standart (1 month) 179 RUB"
        static let oneYearSubscriptionText = "Super (1 year) 1599 RUB"
        static let privacyMattersText = "Privacy Matters"
        static let protectActivitiesWithVPNPlusText = "Protect your activities with VPN Plus"
        static let oneDaysImageName = "1"
        static let oneMonthImageName = "30"
        static let oneYearsImageName = "365"
        static let buttonTitleText = "Buy"
        static let badgeNumber = 1
        static let makeBuyButtonPadding: CGFloat = 10
        static let makeBuyButtonWidth: CGFloat = 80
        static let makeRateImageWidthAndHeight: CGFloat = 100
        static let protectActivitiesTextOffsetYNumber: CGFloat = 30
        static let minLengthSpacerNumber: CGFloat = 60
        static let rateGroupSpacingNumber: CGFloat = 20
        static let oneDayNumber = 1
        static let oneMonthNumber = 30
        static let oneYearNumber = 365
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                privacyMattersTextView
                protectActivitiesTextView
                Spacer(minLength: Constants.minLengthSpacerNumber)
                VStack(spacing: Constants.minLengthSpacerNumber) {
                    VStack(spacing: Constants.rateGroupSpacingNumber) {
                        makeRateImageView(imageName: Constants.oneDaysImageName)
                        makeRateDescriptionTextView(description: Constants.oneDaysSubscriptionText)
                        makeBuyButtonView(day: Constants.oneDayNumber)
                    }
                    VStack(spacing: Constants.rateGroupSpacingNumber) {
                        makeRateImageView(imageName: Constants.oneMonthImageName)
                        makeRateDescriptionTextView(description: Constants.oneMonthSubscriptionText)
                        makeBuyButtonView(day: Constants.oneMonthNumber)
                    }
                    VStack(spacing: Constants.rateGroupSpacingNumber) {
                        makeRateImageView(imageName: Constants.oneYearsImageName)
                        makeRateDescriptionTextView(description: Constants.oneYearSubscriptionText)
                        makeBuyButtonView(day: Constants.oneYearNumber)
                    }
                }
            }
        }
    }
    
    // MARK: - Private Properties
    
    @EnvironmentObject private var ratesViewModel: RatesViewModel
    
    private var privacyMattersTextView: Text {
        Text(Constants.privacyMattersText)
            .font(.title)
    }
    
    private var protectActivitiesTextView: some View {
        Text(Constants.protectActivitiesWithVPNPlusText)
            .font(.title2)
            .offset(y: Constants.protectActivitiesTextOffsetYNumber)
    }
    
    // MARK: - Private Methods
    
    private func makeBuyButtonView(day: Int) -> some View {
        Button(Constants.buttonTitleText) {
            ratesViewModel.daysOfSubscriptionNumber = day
            ratesViewModel.badge = Constants.badgeNumber
        }.padding(Constants.makeBuyButtonPadding)
            .frame(width: Constants.makeBuyButtonWidth)
            .foregroundColor(.white)
            .background(Color.blue)
    }
    
    private func makeRateImageView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .frame(width: Constants.makeRateImageWidthAndHeight, height: Constants.makeRateImageWidthAndHeight)
    }
    
    private func makeRateDescriptionTextView(description: String) -> Text {
        Text(description)
    }
}
