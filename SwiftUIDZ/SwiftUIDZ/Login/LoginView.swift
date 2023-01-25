//
//  LoginView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Экран входа в приложение
struct LoginView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let loginButtonViewLoginText = "Log In"
        static let loginButtonViewSignUpText = "Sign up"
        static let phoneNumberTextFieldViewPromptText = "+0 (000) 000-00-00"
        static let passwordTextFieldViewPromptTex = "⬤⬤⬤⬤⬤⬤⬤"
        static let passwordTextTitleText = "Password"
        static let forgotPasswordButtonViewTitleText = "Forgot your password?"
        static let forgotPasswordButtonViewAlertTitleText = "Служба поддержки:"
        static let forgotPasswordButtonViewAlertMessageText = "8-800-555-35-35"
        static let checkVerificationButtonTitleText = "Check verification"
        static let singUpButtonTitleText = "SING UP"
        static let singUpButtonAlertTitleText = "Ой!"
        static let singUpButtonAlertMessageText = "Пароль должен быть не менее 6 и не более 15 символов"
        static let lightPurpleColorName = "lightPurple"
        static let darkPurpleColorName = "darkPurple"
        static let lightGrayColorName = "lightGray"
        static let minPasswordSymbols = 6
        static let maxPhoneSymbols = 17
        static let maxPasswordSymbols = 15
        static let cornerRadiusValue: CGFloat = 35
        static let cornerRadiusPlusThreeValue: CGFloat = 38
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        NavigationView {
            VStack {
                gradientNavigationView
                VStack(spacing: 50) {
                    loginButtonView
                    phoneNumberTextFieldView
                    passwordTextFieldView
                    singUpButtonView
                    checkVerificationButtonView
                    forgotPasswordButtonView
                    Spacer()
                    NavigationLink(destination: VerificationCodeView(), isActive: $loginViewModel.isCheckVerificationPressed, label: { EmptyView()})
                    NavigationLink(destination: SelectFurnitureView(), isActive: $loginViewModel.isTransitionToSelectFurniture, label: { EmptyView()})
                }
                .offset(y: 50)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onTapGesture {
            isPhoneNumberTextFieldFocused = false
            isPasswordTextFieldFocused = false
        }
        .navigationBarBackButtonHidden()
    }
  
    // MARK: - Private Properties
    
    @StateObject private var loginViewModel = LoginViewModel()
    @FocusState private var isPhoneNumberTextFieldFocused: Bool
    @FocusState private var isPasswordTextFieldFocused: Bool
    
    private var phoneNumberTextFieldView: some View {
        VStack {
            TextField(Constants.emptyString, text: $loginViewModel.phoneNumberTextFieldText, prompt: Text(Constants.phoneNumberTextFieldViewPromptText)
            .foregroundColor(.black.opacity(0.8)))
            .font(.system(size: 30))
            .keyboardType(.numberPad)
            .padding(.horizontal, 50)
            .accentColor(.black)
            .textFieldStyle(.plain)
            .focused($isPhoneNumberTextFieldFocused)
            .onChange(of: loginViewModel.phoneNumberTextFieldText) { newValue in
                loginViewModel.formatterNumberStyle(text: &loginViewModel.phoneNumberTextFieldText, newValue: newValue)
                loginViewModel.maximumCharacterPhoneLimit(newValue: newValue)
                if newValue.count == Constants.maxPhoneSymbols {
                    isPhoneNumberTextFieldFocused = false
                    isPasswordTextFieldFocused = true
                }
            }
            .textFieldStyle(.roundedBorder)
            Divider()
            .padding(.horizontal, 50)
        }
    }
    
    private var passwordTextFieldView: some View {
        VStack {
            Text(Constants.passwordTextTitleText)
                .font(.system(size: 20))
                .offset(x: -100)
            SecureField(Constants.emptyString, text: $loginViewModel.passwordTextFieldText, prompt: Text(Constants.passwordTextFieldViewPromptTex)
                .font(.system(size: 17))
                .kerning(15)
                .foregroundColor(.gray.opacity(0.5)))
                .font(.system(size: 30))
                .keyboardType(.numberPad)
                .padding(.horizontal, 50)
                .accentColor(.black)
                .textFieldStyle(.plain)
                .focused($isPasswordTextFieldFocused)
                .onChange(of: loginViewModel.passwordTextFieldText) { newValue in
                    loginViewModel.maximumCharacterPassword(newValue: newValue)
            }
            .textFieldStyle(.roundedBorder)
            Divider()
                .padding(.horizontal, 50)
        }
    }
    
    private var forgotPasswordButtonView: some View {
        PurpleTextButtonView(action: {
            loginViewModel.isForgotPasswordButtonViewIsPressed = true
        }, label: Constants.forgotPasswordButtonViewTitleText, offset: -20)
        .alert(isPresented: $loginViewModel.isForgotPasswordButtonViewIsPressed) {
            Alert(title: Text(Constants.forgotPasswordButtonViewAlertTitleText), message: Text(Constants.forgotPasswordButtonViewAlertMessageText) , dismissButton: .cancel())
        }
    }
    
    private var checkVerificationButtonView: some View {
        RedGradientButtonView(action: {
            loginViewModel.isCheckVerificationPressed = true
        }, label: Constants.checkVerificationButtonTitleText, offset: 30)
    }
    
    private var singUpButtonView: some View {
        RedGradientButtonView(action: {
            loginViewModel.examinationPassword()
        }, label: Constants.singUpButtonTitleText, offset: 50)
        .alert(isPresented: $loginViewModel.isPasswordLengthMatch) {
            Alert(title: Text(Constants.singUpButtonAlertTitleText), message: Text(Constants.singUpButtonAlertMessageText) , dismissButton: .cancel())
        }
    }
    
    private var gradientNavigationView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 70)
            .background(LinearGradient(
                colors: [.yellow.opacity(1),
                .red.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
            .padding(.bottom, 5)
    }
    
    private var loginButtonView:some View {
        return HStack(spacing: -5) {
            ZStack {
                Rectangle()
                    .frame(width: 155, height: 74)
                    .cornerRadius(Constants.cornerRadiusPlusThreeValue, corners: .topLeft)
                    .cornerRadius(Constants.cornerRadiusPlusThreeValue, corners: .bottomLeft)
                    .foregroundColor(.gray.opacity(0.5))
                Text(Constants.loginButtonViewLoginText)
                    .frame(width: 150, height: 70)
                    .background(.white)
                    .cornerRadius(Constants.cornerRadiusValue, corners: .topLeft)
                    .cornerRadius(Constants.cornerRadiusValue, corners: .bottomLeft)
                    .foregroundColor(Color(Constants.lightPurpleColorName))
                    .font(.system(size: 37, design: .rounded))
                    .font(Font.headline.weight(.bold))
            }
            ZStack {
                Rectangle()
                    .frame(width: 155, height: 74)
                    .cornerRadius(Constants.cornerRadiusPlusThreeValue, corners: .topRight)
                    .cornerRadius(Constants.cornerRadiusPlusThreeValue, corners: .bottomRight)
                    .foregroundColor(.gray.opacity(0.5))
                Text(Constants.loginButtonViewSignUpText)
                    .frame(width: 150, height: 70)
                    .background(Color(Constants.lightGrayColorName))
                    .cornerRadius(Constants.cornerRadiusValue, corners: .topRight)
                    .cornerRadius(Constants.cornerRadiusValue, corners: .bottomRight)
                    .foregroundColor(Color(Constants.darkPurpleColorName))
                    .font(.system(size: 37, design: .rounded))
                    .font(Font.headline.weight(.bold))
            }
        }
    }
}

/// Модификатор закругления 1 угла
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
