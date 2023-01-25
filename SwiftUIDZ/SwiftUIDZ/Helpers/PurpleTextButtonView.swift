//
//  PurpleTextButtonView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import SwiftUI

/// Фиолетовая кнопка без обводки
struct PurpleTextButtonView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let widthNumber: CGFloat = 270
        static let heightNumber: CGFloat = 70
        static let fontSizeNumber: CGFloat = 20
        static let darkPurpleColorName = "darkPurple"
    }
    
    // MARK: - Public Properties
    
    let actionHandler: () -> ()
    let label: String
    let font: Font = Font.system(size: Constants.fontSizeNumber, design: .default)
    let width = Constants.widthNumber
    let height = Constants.heightNumber
    let offset: CGFloat
    
    var body: some View {
        Button {
            actionHandler()
        } label: {
            Text(label)
                .font(font)
                .foregroundColor(Color(Constants.darkPurpleColorName))
        }
        .frame(width: width, height: height)
        .offset(y: offset)
    }
}

