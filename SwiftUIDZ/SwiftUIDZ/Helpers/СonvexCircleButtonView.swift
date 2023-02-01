//
//  СonvexCircleButtonView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 31.01.2023.
//

import SwiftUI

/// Круглая выпирающая кнопка
struct СonvexCircleButtonView: View {
    
    // MARK: - Private Constants
    private enum Constants {
        static let backgroundColorName = "back2"
        static let lightShadowColorName = "ligth"
        static let darkShadowColorName = "dark"
        static let emptyString = ""
    }
    
    // MARK: - Public Properties
    
    let actionHandler: () -> Void
    let iconName: String
    
    // MARK: - Public Methods
    
    var body: some View {
        
        Button {
            actionHandler()
        } label: {
            Label {
                Text(Constants.emptyString)
            } icon: {
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [Color.white.opacity(0.15), Color.black.opacity(0.35)], startPoint: .top, endPoint: .bottomTrailing))
                        .frame(width: 62)
                        .overlay(Circle().stroke(LinearGradient(colors: [Color.black.opacity(0.6), Color.white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.8))
                        .padding(.all, 0)
                        .background(Circle().fill(Color(Constants.backgroundColorName)))
                        .shadow(color: Color(Constants.lightShadowColorName).opacity(0.2), radius: 10, x: -6, y: -6)
                        .shadow(color: Color(Constants.darkShadowColorName).opacity(0.5), radius: 10, x: 6, y: 6)
                    Image(iconName)
                }
            }
        }
    }
}
