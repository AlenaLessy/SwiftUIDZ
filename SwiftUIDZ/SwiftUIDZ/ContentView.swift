//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Экран денежных операций
struct ContentView: View {
    
    // MARK: - Private Constants
    private enum Constants {
        static let walletText = "Кошелек"
        static let profileText = "Профиль"
        static let currentBalanceText = "Текущий баланс:"
        static let showSettingsText = "Показать настройки"
        static let rubText = "рублей"
        static let refillTheBalanceButtonTitleText = "Пополнить"
        static let actionSheetRefillTheBalanceText = "Баланс пополнен"
        static let actionSheetWriteOffFundsText = "Деньги списаны"
        static let actionSheetInsufficientFundsText = "Недостаточно средств"
        static let emptyString = ""
        static let openTwoBankAccountText = "Второй счет открыт"
        static let openBankAccountText = "Открыть счет"
        static let refillTheBalanceAlertButtonText = "Пополнить на 50 рублей?"
        static let transfersMoneyAlertTitleText = "Переводы"
        static let transfersMoneyAlertButtonText = "Перевести"
        static let transferMoneyAlertTitleText = "Перевести 50 рублей?"
        
        static let zeroNumber = 0
        static let zeroCGFloatNumber: CGFloat = 0
        static let fiftyNumber = 50
        static let walletTextSpacerHeightNumber: CGFloat = 20
        static let transfersMoneyButtonSpacerHeightNumber: CGFloat = 10
        static let refillTheBalanceButtonSpacerHeightNumber: CGFloat = 150
        static let profileTextSpacerHeightNumber: CGFloat = 20
        static let openBankAccountButtonSpacerHeightNumber: CGFloat = 100
        static let buttonWidthNumber: CGFloat = 100
        static let buttonHeightNumber: CGFloat = 30
        static let cornerRadiusNumber: CGFloat = 10
        static let animationResponseNumber = 0.5
        static let animationDampingFractionNumber = 0.7
        static let animationBlendDurationNumber = 0.3
        static let balanceTwoOffsetY: CGFloat = 30
        static let biasViewNumber: CGFloat = 200
        static let biasTextNumber: CGFloat = 100
    }
    
    @State var isOnToogle = false
    @State var balance = Constants.zeroNumber
    @State var balanceTwo = Constants.fiftyNumber
    @State var isRefillTheBalanceAlert = false
    @State var isBalanceToppedUp = false
    @State var actionSheetText = Constants.emptyString
    @State var isTransfersMoneyAlert = false
    @State var isCreateBankAccount = false
    @State var openTwoBankAccount = Constants.emptyString
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack {
                        Text(Constants.walletText)
                        Spacer().frame(height: Constants.walletTextSpacerHeightNumber)
                        transfersMoneyButton()
                        Spacer().frame(height: Constants.transfersMoneyButtonSpacerHeightNumber)
                        refillTheBalanceButton()
                        Spacer().frame(height: Constants.refillTheBalanceButtonSpacerHeightNumber)
                        Text(Constants.profileText)
                        Spacer().frame(height: Constants.profileTextSpacerHeightNumber)
                        openBankAccountButton()
                        Spacer().frame(height: Constants.openBankAccountButtonSpacerHeightNumber)
                    }
                    Spacer()
                }
                Spacer()
                RoundedRectangle(cornerRadius: Constants.cornerRadiusNumber).fill(Color.yellow).offset(x: isOnToogle ? Constants.biasViewNumber : Constants.zeroCGFloatNumber)
                VStack {
                    makeBankAccount(balance: balance)
                    
                    if isCreateBankAccount {
                        makeBankAccount(balance: balanceTwo).offset(y: Constants.balanceTwoOffsetY)
                    }
                }
                .offset(x: isOnToogle ? Constants.biasTextNumber : Constants.zeroCGFloatNumber)
            }
            Toggle(isOn: $isOnToogle, label: { Text(Constants.showSettingsText)
            }).padding()
        }.animation(.spring(response: Constants.animationResponseNumber, dampingFraction: Constants.animationDampingFractionNumber, blendDuration: Constants.animationBlendDurationNumber))
    }
    
    fileprivate func makeBankAccount(balance: Int) -> some View {
        return VStack {
            Text(Constants.currentBalanceText)
            Text("\(balance) \(Constants.rubText)")
        }
        .actionSheet(isPresented: $isBalanceToppedUp) {
            ActionSheet(title: Text(actionSheetText))
        }
    }
    
    fileprivate func openBankAccountButton() -> Button<Text> {
        return Button {
            if !isCreateBankAccount {
                isCreateBankAccount = true
                openTwoBankAccount = Constants.openTwoBankAccountText
            }
        } label: {
            Text(Constants.openBankAccountText)
        }
    }
    
    fileprivate func refillTheBalanceButton() -> some View {
        return Button {
            isRefillTheBalanceAlert = true
        } label: {
            Text(Constants.refillTheBalanceButtonTitleText)
        }
        .alert(isPresented: $isRefillTheBalanceAlert) {
            Alert(title: Text(Constants.refillTheBalanceButtonTitleText), primaryButton: .default(Text(Constants.refillTheBalanceAlertButtonText), action: {
                balance += Constants.fiftyNumber
                isBalanceToppedUp = true
                actionSheetText = Constants.actionSheetRefillTheBalanceText
                
                            }), secondaryButton: .cancel())
        }

        .frame(width: Constants.buttonWidthNumber, height: Constants.buttonHeightNumber)
        .background(Color.green)
        .foregroundColor(Color.white)
    }
    
    fileprivate func transfersMoneyButton() -> some View {
        return Button {
            isTransfersMoneyAlert = true
        } label: {
            Text(Constants.transfersMoneyAlertTitleText)
        }
        .alert(isPresented: $isTransfersMoneyAlert) {
            Alert(title: Text(Constants.transferMoneyAlertTitleText), primaryButton: .default(Text(Constants.transfersMoneyAlertButtonText), action: {
                if balance >= Constants.fiftyNumber {
                    balance -= Constants.fiftyNumber
                    balanceTwo += Constants.fiftyNumber
                    isBalanceToppedUp = true
                    actionSheetText = Constants.actionSheetWriteOffFundsText
                    
                } else {
                    isBalanceToppedUp = true
                    actionSheetText = Constants.actionSheetInsufficientFundsText
                }
                            }), secondaryButton: .cancel())
        }

        .frame(width: Constants.buttonWidthNumber, height: Constants.buttonHeightNumber)
        .background(Color.green)
        .foregroundColor(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
