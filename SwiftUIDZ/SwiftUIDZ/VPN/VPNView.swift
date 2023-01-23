//
//  VPNView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 22.01.2023.
//

import SwiftUI

/// Вью экрана выбора ВПН
struct VPNView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let alertTitleText = "Включен ВПН - "
        static let alertOkButtonTitle = "Ok"
        static let ipAddressText = "IP Address"
        static let receivedText = "Received"
        static let sentText = "Sent"
        static let zeroMBText = "0 MB"
        static let rateTextDescriptionText = "Service will expire after"
        static let daysText = "days"
        static let imageWidthAndHeightNumber: CGFloat = 200
        static let imageCornerRadiusNumber: CGFloat = 100
        static let circleWidthNumber: CGFloat = 205
        static let vStackSpacingNumber: CGFloat = 20
        static let zeroNumberInt = 0
        static let nameTextViewFontSizeNumber: CGFloat = 25
        static let toggleOffsetYNumber: CGFloat = 15
        static let hStackSpacingNumber: CGFloat = 50
        static let widthTextNumber: CGFloat = 100
        static let textStackOffsetNumber: CGFloat = 50
        static let spacerMinLengthPickerNumber: CGFloat = 40
        static let spacerMinLengthRatesTextNumber: CGFloat = 30
        static let pickerFrameHeightNumber: CGFloat = 50
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack(spacing: Constants.vStackSpacingNumber) {
            ZStack {
                flagCircleView
                countryFlagImageView
            }
            nameTextView
            togglePVNONView
            VStack(spacing: Constants.vStackSpacingNumber) {
                HStack(spacing: Constants.hStackSpacingNumber) {
                    makeLeadingTextView(text: Constants.ipAddressText)
                    makeTrailingTextView(text: vPNViewModel.getIPAddress())
                }
                HStack(spacing: Constants.hStackSpacingNumber) {
                    makeLeadingTextView(text: Constants.receivedText)
                    makeTrailingTextView(text: Constants.zeroMBText)
                }
                HStack(spacing: Constants.hStackSpacingNumber) {
                    makeLeadingTextView(text: Constants.sentText)
                    makeTrailingTextView(text: Constants.zeroMBText)
                }
            }
            .offset(y: Constants.textStackOffsetNumber)
            Spacer(minLength: Constants.spacerMinLengthPickerNumber)
            pickerView
            ratesTextView
            Spacer()
                .frame(height: Constants.spacerMinLengthRatesTextNumber)
        }
    }
    
    // MARK: - Private Properties
    
    @EnvironmentObject private var ratesViewModel: RatesViewModel
    @StateObject private var vPNViewModel = VPNViewModel()
    
    private var countryFlagImageView: some View {
        Image(vPNViewModel.getFlagCountryName())
            .resizable()
            .frame(width: Constants.imageWidthAndHeightNumber, height: Constants.imageWidthAndHeightNumber)
            .cornerRadius(Constants.imageCornerRadiusNumber)
            .aspectRatio(contentMode: .fit)
    }
    
    private var flagCircleView: some View {
        Circle()
            .frame(width: Constants.circleWidthNumber)
    }
    
    private var nameTextView: Text {
        Text(vPNViewModel.getCountryName())
            .font(.system(size: Constants.nameTextViewFontSizeNumber, weight: .bold, design: .serif))
    }
    
    private var togglePVNONView: some View {
        Toggle(Constants.emptyString, isOn: Binding(get: {
            vPNViewModel.isOnToogle
        }, set: { newValue in
            vPNViewModel.isOnToogle = newValue
        }))
        .toggleStyle(BigToggle())
        .offset(y: Constants.toggleOffsetYNumber)
        .alert(isPresented: $vPNViewModel.isOnToogle) {
            Alert(title: Text("\(Constants.alertTitleText)\(vPNViewModel.getCountryName())"),  dismissButton: .default(Text(Constants.alertOkButtonTitle), action: {
                vPNViewModel.isOnToogle = true
            }))
        }
    }
    
    private var pickerView: some View {
        Picker(Constants.emptyString, selection: Binding(get: {
            vPNViewModel.selectionCountryNumber
        }, set: { newValue in
            vPNViewModel.selectionCountryNumber = newValue
            vPNViewModel.isOnToogle = false
        })) {
            ForEach(Constants.zeroNumberInt ..< vPNViewModel.getCountryNames().count) {
                Text(vPNViewModel.getCountryNames()[$0])
            }
        }
        .pickerStyle(.wheel)
        .frame(height: Constants.pickerFrameHeightNumber)
    }
    
    private var ratesTextView: Text {
        Text("\(Constants.rateTextDescriptionText) \(ratesViewModel.getDaysOfSubscriptionNumber()) \(Constants.daysText)")
    }
    
    // MARK: - Private Methods
    
    private func makeLeadingTextView(text: String) -> some View {
        Text(text)
            .frame(width: Constants.widthTextNumber, alignment: .leading)
    }
    
    private func makeTrailingTextView(text: String) -> some View {
        Text(text)
            .frame(width: Constants.widthTextNumber, alignment: .trailing)
            .bold()
    }
}
