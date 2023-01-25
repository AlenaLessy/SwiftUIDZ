//
//  LoginViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 24.01.2023.
//

import Foundation

/// Вью модель  экрана входа
final class LoginViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let leftBracketSymbol = "("
        static let rightBracketSymbol = ")"
        static let plusSymbol = "+"
        static let dashSymbol = "-"
        static let firstNumberPhoneNumberValue = 1
        static let codeNumberPhoneNumberValue = 6
        static let firstThreeNumberInPhoneNumberValue = 11
        static let firstTwoNumberInPhoneNumberValue = 14
        static let maxPhoneSymbols = 17
        static let maxPasswordSymbols = 16
        static let minPasswordSymbols = 6
    }
    
    // MARK: - Public Properties
    
    @Published var phoneNumberTextFieldText = Constants.emptyString
    @Published var lastPhoneNumberTextFieldText = Constants.emptyString
    @Published var passwordTextFieldText = Constants.emptyString
    @Published var lastPasswordTextFieldText = Constants.emptyString
    @Published var isForgotPasswordButtonViewIsPressed = false
    @Published var isPasswordLengthMatch = false
    @Published var isCheckVerificationPressed = false
    @Published var isTransitionToSelectFurniture = false
    
    // MARK: - Private Properties
    
    private let furnitures = Furniture.getFurniture()
    
    // MARK: - Public Methods
    
    func getRandomFurnitureImage() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(furnitures.count)))
        return furnitures[randomIndex].imageURLString
    }
    
    func formatterNumberStyle(text: inout String, newValue: String) {
        if newValue.count == Constants.firstNumberPhoneNumberValue {
            text = "\(Constants.plusSymbol)\(text)\(Constants.leftBracketSymbol)"
        } else if newValue.count == Constants.codeNumberPhoneNumberValue {
            text = "\(text)\(Constants.rightBracketSymbol) "
        } else if newValue.count == Constants.firstThreeNumberInPhoneNumberValue {
            text = "\(text)\(Constants.dashSymbol)"
        } else if newValue.count == Constants.firstTwoNumberInPhoneNumberValue {
            text = "\(text)\(Constants.dashSymbol)"
        }
        
        
    }
    
    func maximumCharacterPhoneLimit(newValue: String) {
        if newValue.count <= Constants.maxPhoneSymbols {
            lastPhoneNumberTextFieldText = phoneNumberTextFieldText
        }  else {
            phoneNumberTextFieldText = lastPhoneNumberTextFieldText
        }
    }
    
    func maximumCharacterPassword(newValue: String) {
        if newValue.count <= Constants.maxPasswordSymbols {
            lastPhoneNumberTextFieldText = passwordTextFieldText
        } else {
            passwordTextFieldText = lastPhoneNumberTextFieldText
        }
    }
    
    func examinationPassword() {
        if passwordTextFieldText.count < Constants.minPasswordSymbols || passwordTextFieldText.count >= Constants.maxPasswordSymbols {
            isPasswordLengthMatch = true
        } else {
            isTransitionToSelectFurniture = true
        }
    }
}



