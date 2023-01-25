//
//  VerificationCodeView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 24.01.2023.
//

import SwiftUI

/// Экрана верификации с помощью смс кода
struct VerificationCodeView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let verificationCodeText = "Verification code"
        static let checkTheSMSText = "Check the SMS"
        static let messageGetVerificationCodeText = "message to get a verification code"
        static let didReceiveSmsText = "Did't receive sms"
        static let mailImageName = "mail"
        static let continueButtonViewTitleText = "Continue"
        static let continueButtonActionSheetTitleText = "We already know about the bug and fix it sooon"
        static let sendSMSAgainButtonViewTitleText = "Send sms again"
        static let sendSMSAgainAlertMessageText = "Fill in from message"
        static let sendSMSAgainAlertOkButtonTitleText = "Ok"
        static let placeholderTextFieldsText = "0"
        static let toolBarItemText = "Verification"
        static let chevronLeftSystemImageName = "chevron.left"
        static let lengthSMSCodeNumber = 4
        static let firstSMSCodeNumber = 0
        static let secondSMSCodeNumber = 1
        static let threeSMSCodeNumber = 2
        static let fourSMSCodeNumber = 3
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        NavigationView {
            VStack {
                gradientNavigationView
                VStack(spacing: 30) {
                    mailImageView
                    verificationCodeTextView
                        .font(.system(size: 25))
                    verificationTextFieldsView
                    checkTheSMSTextView
                    messageGetVerificationCodeTextView
                    progressView
                    continueButtonView
                    didReceiveSMSTextView
                    sendSMSAgainButtonView
                    Spacer()
                }
                .offset(y: 20)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onTapGesture {
            oneNumberVerificationTextFieldViewFocus = false
            twoNumberVerificationTextFieldViewFocus = false
            threeNumberVerificationTextFieldViewFocus = false
            fourNumberVerificationTextFieldViewFocus = false
        }
        .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(Constants.toolBarItemText)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationBarItems(leading: backButtonView)
    }
    
    // MARK: - Private Properties
    
    @Environment(\.presentationMode) var presentation
    @StateObject private var verificationViewModel = VerificationCodeViewModel()
    @FocusState private var oneNumberVerificationTextFieldViewFocus: Bool
    @FocusState private var twoNumberVerificationTextFieldViewFocus: Bool
    @FocusState private var threeNumberVerificationTextFieldViewFocus: Bool
    @FocusState private var fourNumberVerificationTextFieldViewFocus: Bool
    @State private var randomCode = Constants.emptyString
    
    private var sendSMSAgainButtonView: some View {
        PurpleTextButtonView(action: {
            verificationViewModel.isSendSMSAgainButtonViewPressed = true
            randomCode = verificationViewModel.getRandomSMSCode()
        }, label: Constants.sendSMSAgainButtonViewTitleText, offset: 10)
        .alert(isPresented: $verificationViewModel.isSendSMSAgainButtonViewPressed) {
            
            Alert(title: Text(randomCode), message: Text(Constants.sendSMSAgainAlertMessageText), primaryButton: .default(Text(Constants.sendSMSAgainAlertOkButtonTitleText), action: {
                let characters = Array( randomCode)
                guard characters.count == Constants.lengthSMSCodeNumber else { return }
                verificationViewModel.oneNumberVerificationTextFieldViewText = String(characters[Constants.firstSMSCodeNumber])
                verificationViewModel.twoNumberVerificationTextFieldViewText = String(characters[Constants.secondSMSCodeNumber])
                verificationViewModel.threeNumberVerificationTextFieldViewText = String(characters[Constants.threeSMSCodeNumber])
                verificationViewModel.fourNumberVerificationTextFieldViewText = String(characters[Constants.fourSMSCodeNumber])
            }), secondaryButton: .cancel())
        }
    }
    
    private var verificationTextFieldsView: some View {
        HStack(spacing: 20) {
            OneNumberTextField(promt: Constants.placeholderTextFieldsText, text: $verificationViewModel.oneNumberVerificationTextFieldViewText)
                .focused($oneNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.oneNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.oneNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    twoNumberVerificationTextFieldViewFocus = true
                }
            
            OneNumberTextField(promt: Constants.placeholderTextFieldsText, text: $verificationViewModel.twoNumberVerificationTextFieldViewText)
                .focused($twoNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.twoNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.twoNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    threeNumberVerificationTextFieldViewFocus = true
                }
            
            OneNumberTextField(promt: Constants.placeholderTextFieldsText, text: $verificationViewModel.threeNumberVerificationTextFieldViewText)
                .focused($threeNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.threeNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.threeNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    fourNumberVerificationTextFieldViewFocus = true
                }
            
            OneNumberTextField(promt: Constants.placeholderTextFieldsText, text: $verificationViewModel.fourNumberVerificationTextFieldViewText)
                .focused($fourNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.fourNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.fourNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    fourNumberVerificationTextFieldViewFocus = false
                }
        }
    }
    
    private var progressView: some View {
        ProgressView(Constants.emptyString,
                     value: Double(verificationViewModel.progressViewCountCurrentNumber),
                     total: Double(verificationViewModel.progressViewMaxCountNumber))
        .padding(.horizontal, 50)
        .tint(.yellow)
    }
    
    private var continueButtonView: some View {
        RedGradientButtonView(action: {
            verificationViewModel.isContinueButtonPressed = true
            verificationViewModel.startProgressView()
        }, label: Constants.continueButtonViewTitleText, offset: 50)
        .actionSheet(isPresented: $verificationViewModel.isContinueButtonPressed, content: {
            ActionSheet(title: Text(Constants.continueButtonActionSheetTitleText))
        })
    }
    
    private var mailImageView: some View {
        Image(Constants.mailImageName)
            .resizable()
            .frame(width: 120, height: 120)
    }
    
    private var gradientNavigationView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 10)
            .background(LinearGradient(
                colors: [.yellow.opacity(1),
                         .red.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
            .padding(.bottom, 5)
    }
    
    private var verificationCodeTextView: Text {
        Text(Constants.verificationCodeText)
    }
    
    private var checkTheSMSTextView: Text {
        return Text(Constants.checkTheSMSText)
            .font(.system(size: 25))
            .font(.largeTitle)
            .bold()
    }
    
    private var messageGetVerificationCodeTextView: some View {
        Text(Constants.messageGetVerificationCodeText)
            .font(.system(size: 18))
            .offset(y: -20)
    }
    
    private var didReceiveSMSTextView: some View {
        return Text(Constants.didReceiveSmsText)
            .font(.system(size: 18))
            .offset(y: 50)
    }
    
    private var backButtonView: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Image(systemName: Constants.chevronLeftSystemImageName)
                .resizable()
                .frame(width: 20, height: 30)
                .foregroundColor(.white)
        }
    }
}
