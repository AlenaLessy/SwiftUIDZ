//
//  VerificationCodeView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 24.01.2023.
//

import SwiftUI

/// Экрана верификации с помощью смс кода
struct VerificationCodeView: View {
    @FocusState var oneNumberVerificationTextFieldViewFocus: Bool
    @FocusState var twoNumberVerificationTextFieldViewFocus: Bool
    @FocusState var threeNumberVerificationTextFieldViewFocus: Bool
    @FocusState var fourNumberVerificationTextFieldViewFocus: Bool
    @StateObject var verificationViewModel = VerificationCodeViewModel()
   @State private var randomCode = ""
    var body: some View {
        NavigationView {
            VStack {
                gradientNavigationView
                VStack(spacing: 30) {
                    mailImageView
                    Text("Verification code")
                        .font(.system(size: 25))
                    verificationTextFieldsView
                   Text("Check the SMS")
                      // .font(.system(size: 25))
                        .font(.system(size: 25))
                        .font(Font.headline.weight(.bold))
                    Text("message to geta verification code")
                        .font(.system(size: 18))
                        .offset(y: -20)
                    progressView
                    continueButtonView
                    Text("Did't receive sms ")
                        .font(.system(size: 18))
                        .offset(y: 50)
                    sendSMSAgainButtonView
                    Spacer()
                    //                    NavigationLink(destination: VerificationCodeView(), isActive: $loginViewModel.isCheckVerificationPressed, label: { EmptyView()})
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
        //  .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.large)
        //        .navigationTitle("Verification")
        //        .navigationTitle("Verification")
        //         .foregroundColor(.white)
        //        .font(.system(size: 30))
        
        
        
        
        
    }
    
    private var sendSMSAgainButtonView: some View {
        PurpleTextButtonView(action: {
            verificationViewModel.isSendSMSAgainButtonViewPressed = true
        randomCode = verificationViewModel.getRandomSMSCode()
        }, label: "Send sms again", offset: 10)
        .alert(isPresented: $verificationViewModel.isSendSMSAgainButtonViewPressed) {
          
            Alert(title: Text(randomCode), message: Text("Fill in from message"), primaryButton: .default(Text("Ok"), action: {
               let characters = Array( randomCode)
                verificationViewModel.oneNumberVerificationTextFieldViewText = String(characters[0])
                verificationViewModel.twoNumberVerificationTextFieldViewText = String(characters[1])
                verificationViewModel.threeNumberVerificationTextFieldViewText = String(characters[2])
                verificationViewModel.fourNumberVerificationTextFieldViewText = String(characters[3])
            }), secondaryButton: .cancel())
        }
    }
    
    private var verificationTextFieldsView: some View {
        HStack(spacing: 20) {
            OneNumberTextField(promt: "0", text: $verificationViewModel.oneNumberVerificationTextFieldViewText)
                .focused($oneNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.oneNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.oneNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    twoNumberVerificationTextFieldViewFocus = true
                }
            OneNumberTextField(promt: "5", text: $verificationViewModel.twoNumberVerificationTextFieldViewText)
                .focused($twoNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.twoNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.twoNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    threeNumberVerificationTextFieldViewFocus = true
                }
            OneNumberTextField(promt: "5", text: $verificationViewModel.threeNumberVerificationTextFieldViewText)
                .focused($threeNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.threeNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.threeNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    
                    fourNumberVerificationTextFieldViewFocus = true
                    
                }
            OneNumberTextField(promt: "8", text: $verificationViewModel.fourNumberVerificationTextFieldViewText)
                .focused($fourNumberVerificationTextFieldViewFocus)
                .onChange(of: verificationViewModel.fourNumberVerificationTextFieldViewText) { newChars in
                    verificationViewModel.fourNumberVerificationTextFieldViewText = verificationViewModel.getSMSText(newChars: newChars)
                    fourNumberVerificationTextFieldViewFocus = false
                }
            
        }
    }
    
    private var progressView: some View {
        ProgressView("", value: Double( verificationViewModel.progressViewCountCurrentNumber),
                     total: Double ( verificationViewModel.progressViewMaxCountNumber))
        .padding(.horizontal, 50)
        .tint(.yellow)
        
    }

    private var continueButtonView: some View {
        RedGradientButtonView(action: {
            verificationViewModel.isContinueButtonPressed = true
            verificationViewModel.startProgressView()
        }, label: "Continue", offset: 50)
        .actionSheet(isPresented: $verificationViewModel.isContinueButtonPressed, content: {
            ActionSheet(title: Text("We already know about the bug and fix it sooon"))
        })
    }
        
    private var mailImageView: some View {
        Image("mail")
            .resizable()
            .frame(width: 120, height: 120)
    }
    
    private var gradientNavigationView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 10)
            .background(LinearGradient(colors: [.yellow.opacity(1), .red.opacity(0.7)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .padding(.bottom, 5)
    }
}
