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
    }
    
    // MARK: - Public Properties
    @Published var phoneNumberTextFieldText = Constants.emptyString
    @Published var LastPhoneNumberTextFieldText = Constants.emptyString
    @Published var passwordTextFieldText = Constants.emptyString
    @Published var LastPasswordTextFieldText = Constants.emptyString
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
}
