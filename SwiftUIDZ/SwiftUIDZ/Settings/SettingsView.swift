//
//  SettingsView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Вью-модель экрана настроек
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let openCarButtonTagNumber = 1
        static let teslaImageName = "tesla"
        static let openTeslaImageName = "opentesla"
        static let closeText = "Закрыть"
        static let openText = "Открыть"
        static let lockOpenFillSystemImageName = "lock.open.fill"
        static let lockFillSystemImageName = "lock.fill"
    }
    
    // MARK: - Public Properties
    
    @Published var buttonTagSelected = 0
    @Published var isCarClose = false
    
    
    // MARK: - Public Methods
    
    func isOpenCarButtonPressed() -> Bool {
        if buttonTagSelected == Constants.openCarButtonTagNumber {
            return true
        } else {
            return false
        }
    }
    
    func getTeslaOrOpenTeslaImageName() -> String {
       isCarClose ? Constants.openTeslaImageName : Constants.teslaImageName
    }
    
    func getCloseCarControlTitleText() -> String {
        isCarClose ? Constants.closeText : Constants.openText
    }
        
    func getCloseCarControlIconName() -> String {
        isCarClose ? Constants.lockOpenFillSystemImageName : Constants.lockFillSystemImageName
    }
}

/// Экран настроек
struct SettingsView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let backgroundColorName = "Background"
        static let gradientTopColorName = "GradientTop"
        static let gradientBottomColorName = "GradientBottom"
        static let controlPanelButtonsCountNumber = 5
        static let headerNameText = "Tesla"
        static let headerSpeedText = "187 km"
       
    }
    
  // MARK: - Public Properties

    var body: some View {
        BackgroundStackView {
            VStack {
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
                    }
                } label: {
                    Image("\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .neumorphismSelectedCircleStyle()
                        .overlay(
                            Circle()
                                .stroke(gradient, lineWidth: 2)
                                .opacity(settingsViewModel.buttonTagSelected == index ? 1: 0)
                        )
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 50).fill(Color(Constants.backgroundColorName)))
        .neumorphismUnSelectedStyle()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environment(\.colorScheme, .dark)
    }
}
