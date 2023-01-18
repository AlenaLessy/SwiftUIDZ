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
        
        
        static let alertButtonsAndLogicText = "Пример Alert c 2 кнопками и логикой"
        static let LabelAlertText = "Пример Alert"
        static let labelActionSheetText = "Пример ActionSheet"
        static let labelActionSheetWithButtonText = "Пример ActionSheet c кнопками и логикой"
        static let buttonsLabelText = "Показать"
        static let alertOneTitleText = "Пример алерта"
        static let alertTwoTitleText = "Изменить текст кнопки?"
        static let alertTwoDefaultButtonTitle = "Меняем"
        static let newValueText = "Новый текст"
        static let actionSheetTitleText = "А вот он я"
        static let actionSheetAlarmTitle = "Внимание!"
        static let actionSheetTwoMessageText = "Сейчас будем менять цвета!"
        static let actionSheetTwoDefaultButtonText =  "меняем цвет надписи"
        static let cornerRadiusNumber: CGFloat = 5
        static let paddingNumber: CGFloat = 15
    }
    
    @State var isAlertExample = false
    @State var isTwoButtonAlertExample = false
    @State var isActionSheetExample = false
    @State var isActionSheetTwoExample = false
    @State var oldValueText = Constants.labelActionSheetWithButtonText
    @State var textColor = Color.black
    
    var body: some View {
        VStack {
            Text(Constants.LabelAlertText).foregroundColor(.black)
            showAlert().padding(Constants.paddingNumber)
               
            Text(oldValueText)
            showTwoButtonAlert().padding(Constants.paddingNumber)
            
            Text(Constants.labelActionSheetText)
            showActionSheet().padding(Constants.paddingNumber)
            
            Text(Constants.labelActionSheetWithButtonText).foregroundColor(textColor)
            showTwoAсtionSheet().padding(Constants.paddingNumber)
        }
    }
    
    fileprivate func showAlert() -> some View {
        return Button(action: {
            isAlertExample = true
        },
                      label: {
            Text(Constants.buttonsLabelText)
        })
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(Constants.cornerRadiusNumber)
        .alert(isPresented: $isAlertExample) {
            Alert(title: Text(Constants.alertOneTitleText))
        }
    }
    
    fileprivate func showTwoButtonAlert() -> some View {
        return Button(action: {
            isTwoButtonAlertExample = true
        },
                      label: {
            Text(Constants.buttonsLabelText)
        })
        .foregroundColor(.white)
        .cornerRadius(Constants.cornerRadiusNumber)
        .background(.brown)
        
        .alert(isPresented: $isTwoButtonAlertExample) {
            Alert(title: Text(Constants.alertTwoTitleText), primaryButton: .default(Text(Constants.alertTwoDefaultButtonTitle), action: {
                oldValueText = Constants.newValueText
            }), secondaryButton: .cancel())
        }
    }
    
    fileprivate func showActionSheet() -> some View {
        return Button(action: {
            isActionSheetExample = true
        },
                      label: {
            Text(Constants.buttonsLabelText)
        })
        .foregroundColor(.white)
        .cornerRadius(Constants.cornerRadiusNumber)
        .background(.red)
        .actionSheet(isPresented: $isActionSheetExample, content: { ActionSheet(title: Text(Constants.actionSheetTitleText))})
    }
    
    fileprivate func showTwoAсtionSheet() -> some View {
        return Button(action: {
            isActionSheetTwoExample = true
        },
                      label: {
            Text(Constants.buttonsLabelText)
        })
        .foregroundColor(.white)
        .cornerRadius(Constants.cornerRadiusNumber)
        .background(.green)
        .actionSheet(
            isPresented: $isActionSheetTwoExample, content: {
                ActionSheet(title: Text(Constants.actionSheetAlarmTitle),
                            message: Text(Constants.actionSheetTwoMessageText),
                            buttons: [.default(Text(Constants.actionSheetTwoDefaultButtonText), action: { textColor = .green }),
                                      .cancel()
                                                                                                                                                                   ])})
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
