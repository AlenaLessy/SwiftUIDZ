// ChargingView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран зарядки
struct ChargingView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let backgroundColorName = "back2"
        static let gradientTopColorName = "GradientTop"
        static let gradientBottomColorName = "GradientBottom"
        static let controlPanelButtonsCountNumber = 5
        static let headerNameText = "Tesla"
        static let headerSpeedText = "187 km"
        static let emptyString = ""
        static let settingsButtonViewIconName = "settings"
        static let charging = "CHARGING"
        static let backButtonViewIconName = "chevron"
        static let carImageName = "40"
        static let chargingLightShadow = "chargingLight"
        static let chargingDarkShadow = "chargingDark"
        static let buttonBackgroundColorName = "back2"
        static let buttonShadowColorLightName = "ligth"
        static let buttonShadowColorDarkName = "dark"
        static let chargingProcentText = "65 %"
        static let chargingMiddleValue = "75%"
        static let chargingMaxValue = "100%"
        static let buttonGradientColorName = "buttonGr1"
        static let chevronUpSystemImageName = "chevron.up"
        static let buttonBackgroundLightColorName = "buttonBackground"
        static let nearbySuperchargersText = "Nearby superchargers"
        static let maxChargingValue = 100.0
        static let minChargingValue = 1.0
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        BackgroundStackView(colors: [Color(Constants.backgroundColorName)]) {
            VStack {
                HStack(spacing: 40) {
                    backButtonView
                    TitleTextView
                    settingsButtonView
                }
                .padding(.vertical, 40)
                carImageView
                ZStack {
                    chargingValueTextView
                    volumetricBackRectangleView
                    volumetricFrontRectangleView
                    glowView
                }
                .offset(y: -65)
                chargingSliderView
                    .offset(y: -75)
                     closeCarControlView
                  .offset(y: -100)
                  .padding(.vertical, -40)
                Spacer()
                    .frame(height: 40)
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Private Properties
    
    @Environment(\.presentationMode) private var presentation
    
    @StateObject private var chargingViewModel = ChargingViewModel()
    
    private var chargingValueTextView: some View {
        Text("\(chargingViewModel.getChargingValue())")
            .offset(y: -35)
            .font(.largeTitle)
    }
    private var chargingSliderView: some View {
        VStack {
            scaleView
            ChargeLimitSlider(value: Binding(get: {
                chargingViewModel.changeSliderValue
            }, set: { newValue in
                withAnimation() {
                    chargingViewModel.changeSliderValue = newValue
                }
            }), in: 0...Constants.maxChargingValue, step: Constants.minChargingValue)
            .padding(.leading, 50)
            .offset(y: -10)
        }
    }
    
    private var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.gradientTopColorName), Color(Constants.gradientBottomColorName)],
            startPoint: .bottom,
            endPoint: .top
        )
    }
    
    private var carImageView: some View {
        Image(Constants.carImageName)
            .resizable()
            .frame(width: 370, height: 250)
            .offset(y: -50)
    }
    
    private var scaleView: some View {
        HStack {
            VStack {
                Rectangle()
                    .fill(LinearGradient(
                        colors: [Color(Constants.gradientBottomColorName), Color(Constants.gradientTopColorName)],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(width: 2, height: 9)
                    .padding(.leading, 210)
                Text(Constants.chargingMiddleValue)
                    .font(.caption2)
                    .offset(x: 105)
            }
            VStack {
                Rectangle()
                    .fill(LinearGradient(
                        colors: [Color(Constants.gradientBottomColorName), Color(Constants.gradientTopColorName)],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .opacity(0.5)
                    .frame(width: 2, height: 9)
                    .padding(.leading, 50)
                Text(Constants.chargingMaxValue)
                    .font(.caption2)
                    .padding(.leading, 35)
                    .opacity(0.5)
            }
        }
    }
    
    private var backButtonView: some View {
        ConvexCircleButtonView(actionHandler: {
            presentation.wrappedValue.dismiss()
        }, iconName: Constants.backButtonViewIconName, isEnabled: false)
        .tint(.white)
    }
    
    private var settingsButtonView: some View {
        ConvexCircleButtonView(
            actionHandler: {
                
            },
            iconName: Constants.settingsButtonViewIconName,
            isEnabled: false
        ).tint(.white)
    }
    
    private var volumetricBackRectangleView: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                VolumetricRectangleShape(figureWidth: 1)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(Constants.buttonGradientColorName),
                                Color(Constants.chargingLightShadow),
                                Color(Constants.chargingDarkShadow),
                                .black,
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
            .frame(width: 300, height: 80)
    }
    
    private var volumetricFrontRectangleView: some View {
        VolumetricRectangleShape(figureWidth: chargingViewModel.getChargeProcess())
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(Constants.gradientTopColorName),
                        Color(Constants.gradientTopColorName).opacity(0.5),
                        Color(Constants.gradientBottomColorName).opacity(0.7),
                        Color(Constants.gradientBottomColorName),
                        .white.opacity(0.3),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 300, height: 80)
            .mask(VolumetricRectangleShape(figureWidth: 1))
    }
    
    private var glowView: some View {
        
        HStack {
            Rectangle()
                .fill(LinearGradient( gradient: Gradient(colors: [
                    Color(.clear),
                    Color(Constants.gradientBottomColorName).opacity(0.1),
                    Color(Constants.gradientBottomColorName).opacity(0.2),
                    Color(Constants.gradientBottomColorName).opacity(0.3),
                    Color(Constants.gradientBottomColorName).opacity(0.4),
                    Color(Constants.gradientBottomColorName).opacity(0.5)
                ]),
                                      startPoint: .top,
                                      endPoint: .bottom
                )
                )
                .blur(radius: 10)
                .frame(width: 3 * CGFloat(chargingViewModel.getChargingValue()), height: 100)
            
                .frame(width: 300, height: 100, alignment: .leading)
            
            
                .offset(x: 35, y: -25)
            Spacer()
        }
    }
    
    private var superchargersView: some View {
        Button {
            
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
                        .background(Circle().fill(Color(Constants.buttonBackgroundColorName).opacity(0.7)))
                        .shadow(color: Color(Constants.buttonShadowColorLightName).opacity(0.2), radius: 3, x: 4)
                        .shadow(color: Color(Constants.buttonShadowColorLightName).opacity(0.2), radius: 3)
                    Image(systemName: Constants.chevronUpSystemImageName)
                        .tint(gradient)
                }
            }
        }
        .offset(x: 5)
    }
    
    private var TitleTextView: Text {
        Text(Constants.charging)
            .font(.system(size: 20))
            .bold()
            .font(.title2)
    }
    
    private var closeCarControlView: some View {
        ZStack {
            backgroundCloseCarControlView
            HStack(spacing: 10) {
                Text(Constants.nearbySuperchargersText)
                    .bold()
                superchargersView
            }
        }
        .frame(width: 300, height: 100)
    }
    
    private var backgroundCloseCarControlView: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color(Constants.buttonGradientColorName).opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black.opacity(1), lineWidth: 8)
                    .blur(radius: 8)
                    .offset(x: 2, y: 2)
                    .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color.black, Color.clear)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.15), lineWidth: 8)
                    .blur(radius: 8)
                    .offset(x: -2, y: -2)
                    .mask(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(Color.clear, Color.black)))
            )
    }
}

struct ChargingView_Previews: PreviewProvider {
    static var previews: some View {
        ChargingView()
            .environment(\.colorScheme, .dark)
    }
}
