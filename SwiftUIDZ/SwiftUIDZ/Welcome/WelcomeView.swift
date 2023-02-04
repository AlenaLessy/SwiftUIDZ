// WelcomeView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран приветствия
struct WelcomeView: View {
    // MARK: - Private Constants
    
    private enum Constants {
        static let settingsImageName = "settings"
        static let hiText = "Hi"
        static let welcomeBackText = "Welcome Back"
        static let gradientTopColorName = "GradientTop"
        static let gradientBottomColorName = "GradientBottom"
        static let buttonBackgroundColorName = "back2"
        static let buttonShadowColorLightName = "ligth"
        static let buttonShadowColorDarkName = "dark"
        static let emptyString = ""
        static let backgroundCloseCarControlColorName = "buttonBackground"
    }

    // MARK: - Public Properties

    var body: some View {
        NavigationView {
            ZStack {
                gradientView
                VStack(spacing: 20) {
                    Spacer(minLength: 0)
                    HStack {
                        navigationView
                        settingsButtonView
                    }
                    hiTextView
                    welcomeTextView
                    carImageView
                    closeCarControlView
                    Spacer(minLength: 50)
                }
            }
        }
        .environmentObject(tabbarViewModel)
    }

    // MARK: - Private Properties

    
    @StateObject private var welcomeViewModel = WelcomeViewModel()
    @StateObject private var tabbarViewModel = TabBarViewModel()
    
    @State private var isTabBarHidden = false
  
    private var settingsButtonView: some View {
        ConvexCircleButtonView(actionHandler: {
            welcomeViewModel.isSettingsButtonPressed = true
        }, iconName: Constants.settingsImageName, isEnabled: welcomeViewModel.isSettingsButtonPressed)
            .offset(x: 130, y: -30)
    }

    private var navigationView: some View {
        NavigationLink(destination: TabBarView(startedViewModel: tabbarViewModel), isActive: $welcomeViewModel.isSettingsButtonPressed) {}
    }

    private var hiTextView: Text {
        Text(Constants.hiText)
            .foregroundColor(welcomeViewModel.isChangeImage ? .gray : .black)
            .font(.system(size: 20))
            .font(.title)
            .bold()
    }

    private var welcomeTextView: Text {
        Text(Constants.welcomeBackText)
            .foregroundColor(welcomeViewModel.isChangeImage ? .white : .black)
            .font(.system(size: 40))
            .bold()
    }

    private var carImageView: some View {
        Image(welcomeViewModel.getCarImageName())
            .resizable()
            .frame(width: 407, height: 330)
            .offset(y: welcomeViewModel.isChangeImage ? 20 : -30)
    }

    private var backgroundCloseCarControlView: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(Color(Constants.backgroundCloseCarControlColorName).opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.black.opacity(1), lineWidth: 8)
                    .blur(radius: 8)
                    .offset(x: 2, y: 2)
                    .mask(RoundedRectangle(cornerRadius: 50).fill(LinearGradient(Color.black, Color.clear)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.white.opacity(0.15), lineWidth: 8)
                    .blur(radius: 8)
                    .offset(x: -2, y: -2)
                    .mask(RoundedRectangle(cornerRadius: 50).fill(LinearGradient(Color.clear, Color.black)))
            )
    }

    private var openButtonView: some View {
        Button {
            withAnimation(.linear(duration: 1.5).delay(welcomeViewModel.isLock ? 0 : 1)) {
                welcomeViewModel.isLock.toggle()
                welcomeViewModel.gradientColor()
            }
            withAnimation(.easeIn(duration: 1.5).delay(welcomeViewModel.isChangeImage ? 0.3 : 0)) {
                welcomeViewModel.isChangeImage.toggle()
            }
        } label: {
            Label {
                Text(Constants.emptyString)
            } icon: {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [Color.white.opacity(0.15), Color.black.opacity(0.35)],
                            startPoint: .top,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 44)
                        .overlay(Circle().stroke(
                            LinearGradient(
                                colors: [Color.black.opacity(0.6), Color.white.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        ))
                        .padding(.all, 0)
                        .background(Circle().fill(Color(Constants.buttonBackgroundColorName).opacity(0)))
                        .shadow(color: Color(Constants.buttonShadowColorLightName).opacity(0.2), radius: 3, x: 4)
                        .shadow(color: Color(Constants.buttonShadowColorLightName).opacity(0.2), radius: 3)
                    Image(systemName: welcomeViewModel.getLockIconName())
                        .tint(gradient)
                }
            }
        }
        .offset(x: 5)
    }

    private var closeCarControlView: some View {
        ZStack {
            backgroundCloseCarControlView
            HStack(spacing: 10) {
                Text(welcomeViewModel.getLockTitleText())
                    .bold()
                openButtonView
            }
        }
        .frame(width: 165, height: 79)
    }

    private var gradientView: GradientsBackgroundStackView {
        GradientsBackgroundStackView(
            fromGradientColors: welcomeViewModel.lockGradientColors,
            toGradientColors: welcomeViewModel.unlockGradientColors,
            progress: welcomeViewModel.gradientProgress
        )
    }

    private var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.gradientTopColorName), Color(Constants.gradientBottomColorName)],
            startPoint: .bottom,
            endPoint: .top
        )
    }
}

///
struct ContentViewrews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environment(\.colorScheme, .dark)
    }
}
