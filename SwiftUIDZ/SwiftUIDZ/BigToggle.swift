//
//  BigToggle.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 22.01.2023.
//

import Foundation
import SwiftUI

/// Большой переключатель
struct BigToggle: ToggleStyle {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let toggleWidthNumber: CGFloat = 110
        static let toggleHeightNumber: CGFloat = 60
        static let twoNumber: CGFloat = 2
        static let circleDecreaseNumber: CGFloat = 5
        static let circleIndentNumber: CGFloat = 2
        static let toggleOffsetYNumber: CGFloat = 10
        
    }
    
    // MARK: - Private Properties
    
    let width: CGFloat = Constants.toggleWidthNumber
    let height: CGFloat = Constants.toggleHeightNumber
    
    // MARK: - Public Properties
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label

          ZStack(alignment: configuration.isOn ? .trailing : .leading) {
              RoundedRectangle(cornerRadius:height / Constants.twoNumber)
                    .frame(width: width, height: height)
                    .foregroundColor(configuration.isOn ? .green : .gray)
              Circle()
              
                  .frame(width: height - Constants.circleDecreaseNumber, height: height - Constants.circleDecreaseNumber)
                  .padding(Constants.circleIndentNumber)
                  .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            configuration.$isOn.wrappedValue.toggle()
                        }
                }
              
            }
        }.offset(y: Constants.toggleOffsetYNumber)
    }
}
