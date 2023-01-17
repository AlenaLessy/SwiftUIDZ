//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private Constants
    private enum Constants {
        static let walletText = "Кошелек"
        static let profileText = "Профиль"
        static let currentBalanceText = "Текущий баланс:"
        static let showSettings = "Показать настройки"
        static let rub = "рублей"
        static let refillTheBalanceButtonTitle = "Пополнить"
        static let actionSheetRefillTheBalanceText = "Баланс пополнен"
        static let actionSheetWriteOffFundsText = "Деньги списаны"
        static let actionSheetInsufficientFunds = "Недостаточно средств"
        static let emptyString = ""
        static let openTwoCheck = "Второй счет открыт"
        static let openCheckText = "Открыть счет"
        static let refillTheBalanceAlertButton = "Пополнить на 50 рублей?"
        static let transfersMoneyAlertTitle = "Переводы"
        static let transfersMoneyAlertButton = "Перевести"
        static let transferMoneyAlertTitle = "Перевести 50 рублей?"
        
        
    }
    
    @State var isOnToogle = false
    @State var balance = 0
    @State var balanceTwo = 50
    @State var isRefillTheBalanceAlert = false
    @State var isBalanceToppedUp = false
    @State var actionSheetText = Constants.emptyString
    @State var isTransfersMoneyAlert = false
    @State var isCreateСheck = false
    @State var openTwoCheck = Constants.emptyString
    
    
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    VStack {
                        Text(Constants.walletText)
                        Spacer().frame(height: 20)
                        transfersMoneyButton()
                        Spacer().frame(height: 10)
                        refillTheBalanceButton()
                        Spacer().frame(height: 150)
                        Text(Constants.profileText)
                        Spacer().frame(height: 20)
                        openCheckButton()
                        Spacer().frame(height: 100)
                    }
                    Spacer()
                }
                Spacer()
                RoundedRectangle(cornerRadius: 10).fill(Color.yellow).offset(x: isOnToogle ? 200: 0)
                VStack {
                    makeCheck(balance: balance)
                    
                    if isCreateСheck {
                        makeCheck(balance: balanceTwo).offset(y: 30)
                    }
                }
                .offset(x: isOnToogle ? 100: 0)
            }
            Toggle(isOn: $isOnToogle, label: { Text(Constants.showSettings)
            }).padding()
        }.animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3))
    }
    
    fileprivate func makeCheck(balance: Int
    ) -> some View {
        return VStack {
            Text(Constants.currentBalanceText)
            Text("\(balance) \(Constants.rub)")
        }
        .actionSheet(isPresented: $isBalanceToppedUp) {
            ActionSheet(title: Text(actionSheetText))
            
        }
    }
    
    fileprivate func openCheckButton() -> Button<Text> {
        return Button {
            if !isCreateСheck {
                isCreateСheck = true
                openTwoCheck = Constants.openTwoCheck
            }
        } label: {
            Text(Constants.openCheckText)
        }
    }
    
    fileprivate func refillTheBalanceButton() -> some View {
        return Button {
            isRefillTheBalanceAlert = true
        } label: {
            Text(Constants.refillTheBalanceButtonTitle)
        }
        .alert(isPresented: $isRefillTheBalanceAlert) {
            Alert(title: Text(Constants.refillTheBalanceButtonTitle), primaryButton: .default(Text(Constants.refillTheBalanceAlertButton), action: {
                balance += 50
                isBalanceToppedUp = true
                actionSheetText = Constants.actionSheetRefillTheBalanceText
                
                            }), secondaryButton: .cancel())
        }

        .frame(width: 100, height: 30)
        .background(Color.green)
        .foregroundColor(Color.white)
    }
    
    fileprivate func transfersMoneyButton() -> some View {
        return Button {
            isTransfersMoneyAlert = true
        } label: {
            Text(Constants.transfersMoneyAlertTitle)
        }
        .alert(isPresented: $isTransfersMoneyAlert) {
            Alert(title: Text(Constants.transferMoneyAlertTitle), primaryButton: .default(Text(Constants.transfersMoneyAlertButton), action: {
                if balance >= 50 {
                    balance -= 50
                    balanceTwo += 50
                    isBalanceToppedUp = true
                    actionSheetText = Constants.actionSheetWriteOffFundsText
                    
                } else {
                    isBalanceToppedUp = true
                    actionSheetText = Constants.actionSheetInsufficientFunds
                }
                            }), secondaryButton: .cancel())
        }

        .frame(width: 100, height: 30)
        .background(Color.green)
        .foregroundColor(Color.white)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
