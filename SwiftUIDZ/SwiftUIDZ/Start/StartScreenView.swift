//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Стартовый экран приложения
struct StartScreenView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let onlineFurnitureStoreText = "ONLINE FURNITURE STORE"
        static let dontHaveAccountText = "Don't have an account?"
        static let singInHereButtonTitle = "Sing in here"
        static let getStartedButtonViewTitleText = "GET STARTED"
        static let onlineFurnitureTextfontSizeNumber: CGFloat = 32
        static let onlineFurnitureTextLineSpacingNumber: CGFloat = 15
        static let spacerFrameHeightNumber: CGFloat = 100
        static let dontHaveAccountViewFontSizeNumber: CGFloat = 20
        static let singInHereButtonTitleFontSize: CGFloat = 32
        static let singInHereButtonHeightNumber: CGFloat = 70
        static let singInHereButtonWidthNumber: CGFloat = 270
        static let vStackOffsetYNumber: CGFloat = 60
        static let linearGradientColorRedOpacity: CGFloat = 0.8
        static let zeroCGFloatNumber: CGFloat = 0
        static let imageWidthAndHeightNumber: CGFloat = 200
        static let systemImageQuestionmarkName = "questionmark"
        
    }
    
    // MARK: - Public Properties
        
    var body: some View {
        NavigationView {
            VStack {
                onlineFurnitureTextView
                asyncImageView
                Spacer().frame(height: Constants.spacerFrameHeightNumber)
                getStartedButtonView
                VStack {
                    dontHaveAccountTextView
                    NavigationLink(destination: LoginView(), isActive: $startScreenViewModel.issingInButtonPressed, label: { EmptyView()})
                    NavigationLink(destination: SelectFurnitureView(), isActive: $startScreenViewModel.isgetStartedPressed, label: { EmptyView()})
                    singInHereButtonView
                }.offset(y: Constants.vStackOffsetYNumber)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                LinearGradient(colors: [Color.yellow, Color.red.opacity(Constants.linearGradientColorRedOpacity)], startPoint: .top, endPoint: .bottom)
            )
        }
    }
    
    // MARK: - Private Properties
    
    @StateObject private var startScreenViewModel = StartScreenViewModel()
    
    private var getStartedButtonView: some View {
        RedGradientButtonView(action: {
            startScreenViewModel.isgetStartedPressed = true
        },
                              label: Constants.getStartedButtonViewTitleText,
                              offset: Constants.zeroCGFloatNumber)
    }
    
    private var asyncImageView: some View {
        AsyncImage(url: URL(string: startScreenViewModel.getRandomFurnitureImage())) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .tint(.red)
            case .success(let image):
                image
                    .resizable()
                    .frame(width: Constants.imageWidthAndHeightNumber, height: Constants.imageWidthAndHeightNumber)
            case .failure(let error):
                VStack {
                    Image(systemName: Constants.systemImageQuestionmarkName)
                    Text(error.localizedDescription)
                        .font(.headline)
                }
            @unknown default:
                fatalError()
            }
        }
    }
    
    private var onlineFurnitureTextView: some View {
        return Text(Constants.onlineFurnitureStoreText)
            .font(.system(size: Constants.onlineFurnitureTextfontSizeNumber, design: .default))
            .bold()
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(Constants.onlineFurnitureTextLineSpacingNumber)
    }
    
    private var dontHaveAccountTextView: Text {
        return Text(Constants.dontHaveAccountText)
            .foregroundColor(.white)
            .bold()
            .font(.system(size: Constants.dontHaveAccountViewFontSizeNumber, design: .default))
    }
    
    private var singInHereButtonView: some View {
        Button {
            startScreenViewModel.issingInButtonPressed = true
        } label: {
            Text(Constants.singInHereButtonTitle)
                .font(.system(size: Constants.singInHereButtonTitleFontSize, design: .default))
                .bold()
                .foregroundColor(.white)
                .underline()
        }
        .frame(width: Constants.singInHereButtonWidthNumber, height: Constants.singInHereButtonHeightNumber)
    }
}
