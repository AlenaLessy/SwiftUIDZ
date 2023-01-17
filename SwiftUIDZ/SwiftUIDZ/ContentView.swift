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
        static let oldValueText = "Пример Alert c 2 кнопками и логикой"
        static let LabelOneText = "Пример Alert"
        static let LabelTwoText = "Пример ActionSheet"
        static let LabelThreeText = "Пример ActionSheet c кнопками и логикой"
        static let buttonsLabelText = "Показать"
        static let alertOneTitleText = "Пример алерта"
        static let alertTwoTitleText = "Изменить текст кнопки?"
        static let alertTwoDefaultButtonTitle = "Меняем"
        static let newValueText = "Новый текст"
        static let actionSheetTitleText = "А вот он я"
        static let actionSheetTwoTitleText = "Внимание!"
        static let actionSheetTwoMessageText = "Сейчас будем менять цвета!"
        static let actionSheetTwoDefaultButtonText =  "меняем цвет надписи"
    }
    
    @State var isAlertExample = false
    @State var isTwoButtonAlertExample = false
    @State var isActionSheetExample = false
    @State var isActionSheetTwoExample = false
    @State var oldValueText = Constants.oldValueText
    @State var textColor = Color.black
    
    var body: some View {
        VStack {
            Text(Constants.LabelOneText).foregroundColor(Color.black)
            showAlert().padding(15)
               
            Text(oldValueText)
            showTwoButtonAlert().padding(15)
            
            Text(Constants.LabelTwoText)
            showActionSheet().padding(15)
            
            Text(Constants.LabelThreeText).foregroundColor(textColor)
            showTwoAсtionSheet().padding(15)
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
        .foregroundColor(Color.white)
        .cornerRadius(2)
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
        .foregroundColor(Color.white)
        .cornerRadius(5)
        .background(Color.brown)
        
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
        .foregroundColor(Color.white)
        .cornerRadius(5)
        .background(Color.red)
        
        .actionSheet(isPresented: $isActionSheetExample, content: { ActionSheet(title: Text(Constants.actionSheetTitleText))})
    }
    
    fileprivate func showTwoAсtionSheet() -> some View {
        return Button(action: {
            isActionSheetTwoExample = true
        },
                      label: {
            Text(Constants.buttonsLabelText)
        })
        .foregroundColor(Color.white)
        .cornerRadius(5)
        .background(Color.green)
        
        .actionSheet(
            isPresented: $isActionSheetTwoExample, content: {
                ActionSheet(title: Text(Constants.actionSheetTwoTitleText),
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
