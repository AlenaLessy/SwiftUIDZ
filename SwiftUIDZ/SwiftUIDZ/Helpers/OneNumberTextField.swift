//
//  OneNumberTextField.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 24.01.2023.
//

import SwiftUI

struct OneNumberTextField: View {
    
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let widthNumber: CGFloat = 60
        static let heightNumber: CGFloat = 50
        static let fontSizeNumber: CGFloat = 40
        static let cornerRadiusNumber: CGFloat = 8
        static let emptyString = ""
        static let lineWidthNumber: CGFloat = 4
    }
    
    // MARK: - Public Properties
    
    let promt: String
    let text: Binding<String>
    
    var body: some View {
        TextField(Constants.emptyString, text: text, prompt: Text(promt)
            .font(.system(size: Constants.fontSizeNumber))
            .foregroundColor(.black.opacity(0.7))
        )
        .frame(width: Constants.widthNumber, height: Constants.heightNumber, alignment: .center)
        .font(.system(size: Constants.fontSizeNumber))
        .textFieldStyle(.roundedBorder)
        .frame(width: Constants.widthNumber, height: Constants.heightNumber, alignment: .center)
        .multilineTextAlignment(.center)
        .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadiusNumber)
        .stroke(Color.yellow, lineWidth: Constants.lineWidthNumber))
        .keyboardType(.numberPad)
    }
}
