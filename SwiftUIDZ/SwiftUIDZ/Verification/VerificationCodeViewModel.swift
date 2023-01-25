//
//  VerificationCodeViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import Foundation

/// Вью модель экрана верификации с помощью смс кода
final class VerificationCodeViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let minCountNumberProgressViewNumber = 0
        static let maxCountNumberProgressViewNumber = 5
        static let maxCharsTextFieldNumber = 1
        static let oneProgressViewNumber = 1
        static let minRandomNumber = 0
        static let maxRandomNumber = 9
    }
    
    // MARK: - Public Properties
    
    @Published var oneNumberVerificationTextFieldViewText = Constants.emptyString
    @Published var twoNumberVerificationTextFieldViewText = Constants.emptyString
    @Published var threeNumberVerificationTextFieldViewText = Constants.emptyString
    @Published var fourNumberVerificationTextFieldViewText = Constants.emptyString
    @Published var smsText = Constants.emptyString
    @Published var isContinueButtonPressed = false
    @Published var progressViewCountCurrentNumber = Constants.minCountNumberProgressViewNumber
    @Published var progressViewMaxCountNumber = Constants.maxCountNumberProgressViewNumber
    @Published var isSendSMSAgainButtonViewPressed = false
    @Published var codeText = Constants.emptyString
    
    // MARK: - Public Methods
    
    func getSMSText(newChars: String) -> String {
        if newChars.count <= Constants.maxCharsTextFieldNumber  {
         smsText = newChars
          return smsText
        } else {
           return smsText
        }
    }
    
    func startProgress() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            if self.progressViewCountCurrentNumber == self.progressViewMaxCountNumber {
                timer.invalidate()
            } else {
                self.progressViewCountCurrentNumber += Constants.oneProgressViewNumber
            }
        }
    }
    
    func getRandomSMSCode() -> String {
        let oneNumber = String(Int.random(in: Constants.minRandomNumber...Constants.maxRandomNumber))
        let twoNumber = String(Int.random(in: Constants.minRandomNumber...Constants.maxRandomNumber))
        let threeNumber = String(Int.random(in: Constants.minRandomNumber...Constants.maxRandomNumber))
        let fourNumber = String(Int.random(in: Constants.minRandomNumber...Constants.maxRandomNumber))
        let text = "\(oneNumber)\(twoNumber)\(threeNumber)\(fourNumber)"
        return text
    }
}
