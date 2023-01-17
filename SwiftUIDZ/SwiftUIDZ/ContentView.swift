//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAlertExample = false
    @State var isTwoButtonAlertExample = false
    @State var isActionSheetExample = false
    @State var isActionSheetTwoExample = false
    @State var oldValueText = "Пример Alert c 2 кнопками и логикой"
    @State var textColor = Color.black
    
    var body: some View {
        VStack {
            Text("Пример Alert").foregroundColor(Color.black)
            showAlert().padding(15)
               
            Text(oldValueText)
            showTwoButtonAlert().padding(15)
            Text("Пример ActionSheet")
            showThreeButtonAlert().padding(15)
            Text("Пример ActionSheet c кнопками и логикой").foregroundColor(textColor)
            showButtonAсtionSheet().padding(15)
        }
    }
    
    fileprivate func showAlert() -> some View {
        return Button(action: {
            isAlertExample = true
        },
                      label: {
            Text("Показать")
        })
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(2)
        .alert(isPresented: $isAlertExample) {
            Alert(title: Text("Пример алерта"))
        }
    }
    
    fileprivate func showTwoButtonAlert() -> some View {
        return Button(action: {
            isTwoButtonAlertExample = true
        },
                      label: {
            Text("Показать")
        })
        .foregroundColor(Color.white)
        .cornerRadius(5)
        .background(Color.brown)
        
        .alert(isPresented: $isTwoButtonAlertExample) {
            Alert(title: Text("Изменить текст кнопки?"), primaryButton: .default(Text("Меняем"), action: {
                oldValueText = "Новый текст"
            }), secondaryButton: .cancel())
        }
    }
    
    fileprivate func showThreeButtonAlert() -> some View {
        return Button(action: {
            isActionSheetExample = true
        },
                      label: {
            Text("Показать")
        })
        .foregroundColor(Color.white)
        .cornerRadius(5)
        .background(Color.red)
        
        .actionSheet(isPresented: $isActionSheetExample, content: { ActionSheet(title: Text("А вот он я"))})
    }
    
    fileprivate func showButtonAсtionSheet() -> some View {
        return Button(action: {
            isActionSheetTwoExample = true
        },
                      label: {
            Text("Показать")
        })
        .foregroundColor(Color.white)
        .cornerRadius(5)
        .background(Color.green)
        
        .actionSheet(
            isPresented: $isActionSheetTwoExample, content: {
                ActionSheet(title: Text("Внимание!"),
                            message: Text("Сейчас будем менять цвета!"),
                            buttons: [.default(Text("меняем цвет надписи"), action: { textColor = .green }),
                                      .cancel()
                                                                                                                                                                   ])})
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
