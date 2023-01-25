//
//  RedGradientButtonView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import SwiftUI

/// Красная кнопка с градиентом
struct RedGradientButtonView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let widthNumber: CGFloat = 270
        static let heightNumber: CGFloat = 70
        static let fontSizeNumber: CGFloat = 32
        static let cornerRadiusNumber: CGFloat = 50
    }
    
    // MARK: - Public Properties
    
    let actionHandler: () -> ()
    let label: String
    let font: Font = Font.system(size: Constants.fontSizeNumber, design: .default)
    let offset: CGFloat
    let width = Constants.widthNumber
    let height = Constants.heightNumber
    
    var body: some View {
        Button {
            actionHandler()
        } label: {
            Text(label)
                .font(font)
                .bold()
                .foregroundColor(.white)
        }
        .frame(width: width, height: height)
        .background( LinearGradient(colors: [Color.red, Color.red.opacity(0.3)], startPoint: .bottomTrailing, endPoint: .topLeading))
        .cornerRadius(Constants.cornerRadiusNumber)
        .offset(y: offset)
    }
}
