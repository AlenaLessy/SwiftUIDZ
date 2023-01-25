//
//  SelectFurniture.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 24.01.2023.
//

import SwiftUI

/// Экран выбора мебели
struct SelectFurnitureView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let darkPurpleColorName = "darkPurple"
        static let heartSystemImageName = "heart"
        static let buyNowButtonTitleText = "Buy now"
        static let descriptionProgressViewTitleText = "Символов:"
        static let descriptionProgressViewTitleOrOneHundredText = "из 100"
        static let descriptionTitleImageName = "9"
        static let descriptionTitleText = "Description"
        static let indentOrWidthNumber: CGFloat = 50
        static let maxSymbolNumber: Double = 100
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        NavigationView {
            VStack {
                gradientNavigationView
                VStack(spacing: 10) {
                    VStack(spacing: 30) {
                        furnitureImageView
                        backGroundView
                        descriptionTitleView
                    }
                    descriptionProgressView
                    descriptionTextEditorView
                    Spacer()
                }
                .offset(y: 20)
            }
        }
        .navigationBarBackButtonHidden()
        .onTapGesture {
            isTextEditorFocus = false
        }
    }
    
    // MARK: - Private Properties
    
    @StateObject private var selectFurnitureViewModel = SelectFurnitureViewModel()
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    @FocusState private var isTextEditorFocus: Bool
    
    private var furnitureImageView: some View {
        Image(selectFurnitureViewModel.getRandomFurnitureImage())
            .resizable()
            .frame(width: 250, height: 250)
    }
    
    private var backGroundView: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .shadow(radius: 9)
                .frame(width: UIScreen.main.bounds.width - Constants.indentOrWidthNumber, height: 150)
                .foregroundColor(.white)
            HStack(spacing: 50) {
                VStack(spacing: 10) {
                    Text(selectFurnitureViewModel.getRandomFurnitureName())
                        .bold()
                        .font(.system(size: 30))
                    Rectangle()
                        .frame(width: 100, height: 3)
                        .foregroundColor(.yellow)
                        .offset(y: -5)
                    Text(selectFurnitureViewModel.getRandomFurniturePrice())
                        .font(.system(size: 60))
                        .bold()
                        .foregroundColor(Color(Constants.darkPurpleColorName))
                }
                VStack(spacing: 20) {
                    Image(systemName: Constants.heartSystemImageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                        .offset(x: 30)
                    Button {
                    } label: {
                        Text(Constants.buyNowButtonTitleText)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .bold()
                    }
                    .frame(width: 120, height: 50)
                    .background(Color.red)
                    .cornerRadius(25)
                }
            }
        }
    }
    
    private var descriptionTextEditorView: some View {
        TextEditor(text: $selectFurnitureViewModel.descriptionText)
            .frame(height: 200)
            .background(Color.yellow)
            .padding(.bottom, keyboardResponder.currentHeight)
            .focused($isTextEditorFocus)
    }
    
    private var descriptionProgressView: some View {
        ProgressView(
            "\(Constants.descriptionProgressViewTitleText) \(selectFurnitureViewModel.lastDescriptionChar.count) \(Constants.descriptionProgressViewTitleOrOneHundredText)",
            value: Double(selectFurnitureViewModel.lastDescriptionChar.count),
            total: Constants.maxSymbolNumber
        )
        .padding(.horizontal, 30)
        .tint(.yellow)
        .offset(y: -10)
        .onChange(of: selectFurnitureViewModel.descriptionText) { newValue in
            selectFurnitureViewModel.descriptionText = selectFurnitureViewModel.limitationCharsOfDescriptionTextEditor(totalChars: newValue)
        }
    }
    
    private var descriptionTitleView: some View {
        HStack {
            Image(Constants.descriptionTitleImageName)
                .resizable()
                .frame(width: 70, height: 70)
            Text(Constants.descriptionTitleText)
                .bold()
                .font(.system(size: 25))
            Spacer()
        }
    }
    
    private var gradientNavigationView: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(height: 60)
            .background(LinearGradient(
                colors: [.yellow.opacity(1),
                         .red.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
            .padding(.bottom, 5)
    }
}

struct ContentView: PreviewProvider {
    static var previews: some View {
        SelectFurnitureView()
    }
}
