//
//  SettingsView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Экран настроек
struct SettingsView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let backgroundColorName = "back2"
        static let gradientTopColorName = "GradientTop"
        static let gradientBottomColorName = "GradientBottom"
        static let controlPanelButtonsCountNumber = 5
        static let headerNameText = "Tesla"
        static let headerSpeedText = "187 km"
        static let emptyString = ""
    }
    
  // MARK: - Public Properties

    var body: some View {
        BackgroundStackView(colors: settingsViewModel.backgroundColors) {
                VStack {
                    NavigationLink(destination: ClimateControlView(), isActive: $settingsViewModel.isClimateControlViewDestination) {
                        Text(Constants.emptyString)
                    }
                    headerView
                    carView
                    controlPanelView
                    Spacer()
                        .frame(height: 40)
                    if settingsViewModel.isOpenCarButtonPressed() {
                        closeCarControlView
                    }
                    Spacer()
                }
                .padding()
        }
            .navigationBarHidden(true)
    }
    
    // MARK: - Private Properties
    
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color(Constants.gradientTopColorName), Color(Constants.gradientBottomColorName)], startPoint: .bottom, endPoint: .top)
    }
    
    private var controlPanelView: some View {
        HStack(spacing: 30) {
            ForEach(1 ..< Constants.controlPanelButtonsCountNumber) { index in
                Button {
                    withAnimation {
                        settingsViewModel.buttonTagSelected = index
                        settingsViewModel.isClimateControlButtonPressed()
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(gradient, lineWidth: 2)
                                .opacity(settingsViewModel.buttonTagSelected == index ? 1: 0)
                        )
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color(Constants.backgroundColorName))).neumorphismUnSelectedStyle()
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Constants.headerNameText)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(Constants.headerSpeedText)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .opacity(0.4)
            }
            Spacer()
        }
        .padding(.all, 25)
    }
    
    private var carView: some View {
        Image(settingsViewModel.getTeslaOrOpenTeslaImageName())
            .resizable()
            .frame(width: 250, height: 150)
            .padding(.horizontal)
            .padding(.bottom, 40)
            .shadow(color: .white.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    private var closeCarControlView: some View {
        Button {
            withAnimation {
                settingsViewModel.isCarClose.toggle()
            }
        } label: {
            HStack {
                Label {
                    Text(settingsViewModel.getCloseCarControlTitleText())
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: settingsViewModel.getCloseCarControlIconName())
                        .renderingMode(.template)
                        .foregroundStyle(gradient)
                        .neumorphismSelectedCircleStyle()
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 50).fill(Color(Constants.backgroundColorName)))
            .neumorphismSelectedStyle()
        }
        .frame(width: 300)
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environment(\.colorScheme, .dark)
    }
}
