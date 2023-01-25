//
//  LoginView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Экран входа в приложение
struct LoginView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @FocusState var isPhoneNumberTextFieldFocused: Bool
    @FocusState var isPasswordTextFieldFocused: Bool
    

    
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

    private var phoneNumberTextFieldView: some View {
        VStack {
            TextField("", text: $loginViewModel.phoneNumberTextFieldText, prompt: Text("+0 (000) 000-00-00")
                .foregroundColor(.black.opacity(0.8)))
            
            .font(.system(size: 30))
            .keyboardType(.numberPad)
            .padding(.horizontal, 50)
            .accentColor(.black)
            .textFieldStyle(.plain)
            .focused($isPhoneNumberTextFieldFocused)
            .onChange(of: loginViewModel.phoneNumberTextFieldText) { newValue in
                formatterNumberStyle(text: &loginViewModel.phoneNumberTextFieldText, newValue: newValue)
                if newValue.count <= 16 {
                    loginViewModel.LastPhoneNumberTextFieldText = loginViewModel.phoneNumberTextFieldText
                }
                if newValue.count == 16 {
                    isPhoneNumberTextFieldFocused = false
                    isPasswordTextFieldFocused = true
                }
                else {
                    loginViewModel.phoneNumberTextFieldText = loginViewModel.LastPhoneNumberTextFieldText
                }
            }
            .textFieldStyle(.roundedBorder)
            Divider()
                .padding(.horizontal, 50)
        }
    }
    
    private var passwordTextFieldView: some View {
        VStack {
            Text("Password")
                .font(.system(size: 20))
                .offset(x: -100)
            SecureField("", text: $loginViewModel.passwordTextFieldText, prompt: Text("⬤⬤⬤⬤⬤⬤⬤")
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
                if newValue.count <= 15 {
                    loginViewModel.LastPhoneNumberTextFieldText = loginViewModel.passwordTextFieldText
                } else {
                    loginViewModel.passwordTextFieldText = loginViewModel.LastPhoneNumberTextFieldText
                }
            }
            .textFieldStyle(.roundedBorder)
            Divider()
                .padding(.horizontal, 50)
            
            
        }
    }
    
    private var forgotPasswordButtonView: some View {
        PurpleTextButtonView(action: {
            loginViewModel.isForgotPasswordButtonViewIsPressed = true
        }, label: "Forgot your password?", offset: -20)
        .alert(isPresented: $loginViewModel.isForgotPasswordButtonViewIsPressed) {
            Alert(title: Text("Служба поддержки:"), message: Text("8-800-555-35-35") , dismissButton: .cancel())
        }
    }
   
    private var checkVerificationButtonView: some View {
        RedGradientButtonView(action: {
            loginViewModel.isCheckVerificationPressed = true
        }, label: "Check verification", offset: 30)
    }
    
    private var singUpButtonView: some View {
        RedGradientButtonView(action: {
            if loginViewModel.passwordTextFieldText.count < 6 || loginViewModel.passwordTextFieldText.count >= 15 {
                loginViewModel.isPasswordLengthMatch = true
            
                
            } else {
                loginViewModel.isTransitionToSelectFurniture = true
            }
        }, label: "SING UP", offset: 50)
        .alert(isPresented: $loginViewModel.isPasswordLengthMatch) {
            Alert(title: Text("Ой!"), message: Text("Пароль должен быть не менее 6 и не более 15 символов") , dismissButton: .cancel())
        }
    }
    
    
    private var gradientNavigationView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 70)
            .background(LinearGradient(colors: [.yellow.opacity(1), .red.opacity(0.7)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .padding(.bottom, 5)
    }
    
    private var loginButtonView:some View {
        return HStack(spacing: -5) {
            ZStack {
                Rectangle()
                    .frame(width: 155, height: 74)
                    .cornerRadius(38, corners: .topLeft)
                    .cornerRadius(38, corners: .bottomLeft)
                    .foregroundColor(.gray.opacity(0.5))
                Text("Log In")
                    .frame(width: 150, height: 70)
                    .background(.white)
                    .cornerRadius(35, corners: .topLeft)
                    .cornerRadius(35, corners: .bottomLeft)
                    .foregroundColor(Color("lightPurple"))
                    .font(.system(size: 37, design: .rounded))
                    .font(Font.headline.weight(.bold))
            }
            ZStack {
                Rectangle()
                    .frame(width: 155, height: 74)
                    .cornerRadius(38, corners: .topRight)
                    .cornerRadius(38, corners: .bottomRight)
                    .foregroundColor(.gray.opacity(0.5))
                Text("Sign up")
                    .frame(width: 150, height: 70)
                    .background(Color("lightGray"))
                    .cornerRadius(35, corners: .topRight)
                    .cornerRadius(35, corners: .bottomRight)
                    .foregroundColor(Color("darkPurple"))
                    .font(.system(size: 37, design: .rounded))
                    .font(Font.headline.weight(.bold))
            }
        }
    }
    
    // Private Methods
    private func formatterNumberStyle(text: inout String, newValue: String) {
        //        if newValue.count == 1 {
        //            text = "+\(text)("
        //        } else if newValue.count == 6 {
        //            text = "\(text)) "
        //        } else if newValue.count == 11 {
        //            text = "\(text)-"
        //        } else if newValue.count == 14 {
        //            text = "\(text)-"
        //        }
        //    }
        
        if newValue.count > 0 {
            if newValue[newValue.startIndex] == "8" {
                text.remove(at: text.startIndex)
                text.insert("7", at: text.startIndex)
            }
            if newValue[newValue.startIndex] == "9" {
                text.insert("7", at: text.startIndex)
            }
        }
        
        if newValue.count == 11 {
            text.insert("+", at: text.startIndex)
            text.insert("(", at: text.index(text.startIndex, offsetBy: 2))
            text.insert(")", at: text.index(text.startIndex, offsetBy: 6))
            text.insert("-", at: text.index(text.startIndex, offsetBy: 10))
            text.insert("-", at: text.index(text.startIndex, offsetBy: 13))
        }
        if newValue.count == 15 {
            text.remove(at: text.index(text.startIndex, offsetBy: 13))
            text.remove(at: text.index(text.startIndex, offsetBy: 10))
            text.remove(at: text.index(text.startIndex, offsetBy: 6))
            text.remove(at: text.index(text.startIndex, offsetBy: 2))
            text.remove(at: text.startIndex)
        }
    }
}

/// Модификатор закругления 1 угла
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
