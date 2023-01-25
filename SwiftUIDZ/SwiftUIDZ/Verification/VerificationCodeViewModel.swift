//
//  VerificationCodeViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import Foundation

/// Вью модель экрана верификации с помощью смс кода
final class VerificationCodeViewModel: ObservableObject {
 @Published var oneNumberVerificationTextFieldViewText = ""
    @Published var twoNumberVerificationTextFieldViewText = ""
    @Published var threeNumberVerificationTextFieldViewText = ""
    @Published var fourNumberVerificationTextFieldViewText = ""
    @Published var smsText = ""
    @Published var isContinueButtonPressed = false
    @Published var progressViewCountCurrentNumber = 0
    @Published var progressViewMaxCountNumber = 5
    @Published var isSendSMSAgainButtonViewPressed = false
    @Published var codeText = ""
    
    func getSMSText(newChars: String) -> String {
        if newChars.count <= 1  {
         smsText = newChars
          return smsText
        } else {
           return smsText
        }
    }
    
    func startProgressView() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else { return }
            if self.progressViewCountCurrentNumber == self.progressViewMaxCountNumber {
                timer.invalidate()
            } else {
                self.progressViewCountCurrentNumber += 1
            }
        }
    }
    
    func getRandomSMSCode() -> String {
        let oneNumber = String(Int.random(in: 0...9))
        let twoNumber = String(Int.random(in: 0...9))
        let threeNumber = String(Int.random(in: 0...9))
        let fourNumber = String(Int.random(in: 0...9))

        let text = "\(oneNumber)\(twoNumber)\(threeNumber)\(fourNumber)"
       // codeText = text
        return text
    }

    
}
