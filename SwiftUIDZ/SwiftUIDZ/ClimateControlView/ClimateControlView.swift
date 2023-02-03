// ClimateControlView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Настройки системы кондиционирования
struct ClimateControlView: View {
    // MARK: - Private Constants

    private enum Constants {
        static let gradientTopColorName = "GradientTop"
        static let gradientBottomColorName = "GradientBottom"
        static let buttonBackgroundColorName = "back2"
        static let buttonShadowColorLightName = "ligth"
        static let buttonShadowColorDarkName = "dark"
        static let climateControlTextViewForegroundColor = "buttonGr1"
        static let climateTextViewText = "CLIMATE"
        static let settingsText = "Настройки"
        static let GradientBackgroundTopColorName = "GradientBackgroundTop"
        static let linkText = "Tesla Support"
        static let urlString = "https://www.tesla.com/support"
        static let okText = "Ок"
        static let toolbarTitleText = "CLIMATE"
        static let backButtonViewIconName = "chevron"
        static let settingsButtonViewIconName = "settings"
        static let overlayOneTemperatureIndicatorView = "RoundBack1"
        static let overlayTwoTemperatureIndicatorView = "RoundBack2"
        static let celsiusText = "C"
        static let aCIsONText = "A/C is ON"
        static let bottomSheetTextDescriptionText = "Tap to turn off or swipe up for a fast setup"
        static let onImageName = "on"
        static let chevronLeftSystemImageName = "chevron.left"
        static let chevronRightSystemImageName = "chevron.right"
        static let unionImageName = "Union"
        static let onText = "On"
        static let colorPickerOneText = "Color one"
        static let colorPickerTwoText = "Color two"
        static let ventText = "Vent"
        static let settingsItemsCount = 4
        static let topPartBottomSheetViewSpacingNumber: CGFloat = 20
        static let bottomPartBottomSheetViewSpacingNumber: CGFloat = 70
        static let bottomSheetViewSpacingNumber: CGFloat = 10
        static let halfScreenNumber: CGFloat = 2
        static let maxSteperNumber: CGFloat = 15
    }

    // MARK: - Public Properties

    var body: some View {
        VStack {
            BackgroundStackView(colors: climateControlViewModel.gradientColors) {
                ZStack {
                    VStack(spacing: 0) {
                        HStack(spacing: 55) {
                            backButtonView
                            climateTextView
                            settingsButtonView
                        }
                        .padding(.top, 15)
                        temperatureIndicatorView
                            .padding(.top, 40)
                        DisclosureGroup {
                            ForEach(0 ..< Constants.settingsItemsCount) { index in
                                makeClimateGroupView(index: index)
                            }
                        } label: {
                            Text(Constants.settingsText)
                        }
                        .foregroundColor(.white)
                        .tint(.white)
                        .padding(.horizontal, 10)
                        Spacer()
                    }
                    bottomSheetView
                        .blur(radius: climateControlViewModel.isSettingsButtonPressed ? 20 : 0)
                    if climateControlViewModel.isSettingsButtonPressed {
                        alertView
                            .zIndex(1)
                            .transition(.scale(scale: 0.1, anchor: .bottomTrailing))
                    }
                }
            }
        }
        .onAppear {
            tabbarVM.showTabBar = false
        }
        .navigationBarBackButtonHidden()
    }

    // MARK: - Private Properties

    @Environment(\.presentationMode) private var presentation
    @EnvironmentObject private var tabbarVM: TabBarViewModel
    
    @GestureState private var bottomSheetGestureOffsetValue = CGSize.zero

    @StateObject private var climateControlViewModel = ClimateControlViewModel()

    private var climateTextView: Text {
        Text(Constants.climateTextViewText)
            .font(.system(size: 20))
            .bold()
            .font(.title2)
    }

    private var dragBottomSheetGesture: some Gesture {
        DragGesture()
            .updating($bottomSheetGestureOffsetValue) { value, state, _ in
                state = value.translation
                climateControlViewModel
                    .onChangeBottomSheetOffset(gestureOffsetValue: bottomSheetGestureOffsetValue.height)
            }
            .onEnded { _ in
                withAnimation {
                    climateControlViewModel.bottomSheetOffsetY()
                }
            }
    }

    private var alertButtonView: some View {
        Button {
            climateControlViewModel.isSettingsButtonPressed.toggle()
        } label: {
            Text(Constants.okText)
                .tint(.black)
                .font(.title2)
                .padding(.all, 12)
                .background(Color(Constants.gradientTopColorName))
                .cornerRadius(8)
        }
    }

    private var alertView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(Constants.GradientBackgroundTopColorName))
            RoundedRectangle(cornerRadius: 30)
                .fill(gradient).opacity(0.15)
            VStack(spacing: 30) {
                if let url = URL(string: Constants.urlString) {
                    Link(destination: url) {
                        Text(Constants.linkText)
                            .font(.largeTitle)
                            .underline()
                    }
                    alertButtonView
                }
            }
        }.frame(width: 300, height: 300)
    }

    private var toolbarTitleTextView: some View {
        Text(Constants.toolbarTitleText)
    }

    private var backButtonView: some View {
        ConvexCircleButtonView(actionHandler: {
            presentation.wrappedValue.dismiss()
        }, iconName: Constants.backButtonViewIconName, isEnabled: false).tint(.white)
    }

    private var settingsButtonView: some View {
        ConvexCircleButtonView(
            actionHandler: {
                climateControlViewModel.isSettingsButtonPressed.toggle()
            },
            iconName: Constants.settingsButtonViewIconName,
            isEnabled: climateControlViewModel.isSettingsButtonPressed
        ).tint(.white)
    }

    private var temperatureIndicatorView: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: [Color.black.opacity(0.3), Color.white.opacity(0.1)],
                    startPoint: .top,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 140)
                .overlay(Circle().stroke(
                    LinearGradient(
                        colors: [
                            Color(Constants.overlayOneTemperatureIndicatorView),
                            Color(Constants.overlayTwoTemperatureIndicatorView),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 28
                ))
                .background(Circle().fill(Color(Constants.buttonBackgroundColorName)))
                .shadow(color: Color(Constants.buttonShadowColorLightName).opacity(0.1), radius: 25, x: -17, y: -15)
                .shadow(color: Color(Constants.buttonShadowColorDarkName).opacity(0.5), radius: 20, x: 15, y: 15)

            Circle()
                .fill(.clear)
                .frame(width: 110)
                .overlay(Circle().stroke(
                    LinearGradient(colors: [
                        Color(.black).opacity(0.2),
                        Color(.white).opacity(0.1),
                        Color(.black).opacity(0.2),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 1.5
                ))

            Circle()
                .trim(
                    from: 0,
                    to: climateControlViewModel
                        .isClimateControlEnabled ? (CGFloat(climateControlViewModel.getTemperature()) / 75) : 0
                )
                .stroke(
                    LinearGradient(colors: [
                        Color(climateControlViewModel.bottomGradientColor),
                        Color(climateControlViewModel.topGradientColor),
                    ], startPoint: .top, endPoint: .bottomTrailing),
                    lineWidth: 15
                )
                .frame(width: 168)
                .rotationEffect(.degrees(-90))
                .shadow(color: Color(climateControlViewModel.bottomGradientColor).opacity(0.5), radius: 3, x: -3, y: -3)
                .shadow(color: Color(climateControlViewModel.topGradientColor).opacity(0.5), radius: 3, x: 3, y: 3)
            if climateControlViewModel.isClimateControlEnabled {
                Text("\(climateControlViewModel.getTemperature()) \(Constants.celsiusText)")
            }
        }
    }

    private var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(Constants.gradientTopColorName), Color(Constants.gradientBottomColorName)],
            startPoint: .bottom,
            endPoint: .top
        )
    }

    private var bottomSheetBackGroundView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(Constants.GradientBackgroundTopColorName))
            RoundedRectangle(cornerRadius: 30)
                .fill(gradient).opacity(0.15)
        }
    }

    private var bottomSheetACIsOnTextView: some View {
        HStack {
            Text(Constants.aCIsONText)
                .font(Font.system(size: 18))
                .bold()
            Spacer()
        }
    }

    private var bottomSheetEnableButtonView: some View {
        ConvexCircleButtonView(actionHandler: {
            climateControlViewModel.isClimateControlEnabled.toggle()
        }, iconName: Constants.onImageName, isEnabled: climateControlViewModel.isClimateControlEnabled)
    }

    private var bottomSheetDescriptionTextView: some View {
        Text(Constants.bottomSheetTextDescriptionText)
            .font(Font.system(size: 15, weight: .semibold))
            .foregroundColor(.gray)
    }

    private var bottomSheetCapsuleView: some View {
        Capsule()
            .fill(.black)
            .frame(width: 70, height: 5)
            .padding(.top)
    }

    private var colorPikersAndTextView: some View {
        HStack {
            Text(Constants.onText)
            Spacer()
            ColorPicker(Constants.colorPickerOneText, selection: $climateControlViewModel.topGradientColor)
                .frame(width: 80)
            Spacer()
            ColorPicker(Constants.colorPickerTwoText, selection: $climateControlViewModel.bottomGradientColor)
                .frame(width: 80)
            Spacer()
            Text(Constants.ventText)
        }
    }

    private var steperView: some View {
        HStack {
            Button {
                climateControlViewModel.steperDecrement()
            } label: {
                Image(systemName: Constants.chevronLeftSystemImageName)
                    .resizable()
                    .frame(width: 10, height: 10)
                    .tint(.white)
            }
            Text("\(climateControlViewModel.getTemperature()) \(Constants.celsiusText)")
                .font(.title3)
            Button {
                climateControlViewModel.steperIncrement()
            } label: {
                Image(systemName: Constants.chevronRightSystemImageName)
                    .resizable()
                    .frame(width: 10, height: 10)
                    .tint(.white)
            }
        }
    }

    private var topPartBottomSheetView: some View {
        ZStack {
            bottomSheetBackGroundView
            ZStack {
                HStack {
                    VStack(spacing: -10) {
                        bottomSheetACIsOnTextView
                        HStack {
                            bottomSheetDescriptionTextView
                            Spacer()
                            bottomSheetEnableButtonView
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width - Constants.topPartBottomSheetViewSpacingNumber)
            VStack {
                bottomSheetCapsuleView
                Spacer()
            }
        }
        .frame(height: 130)
    }

    private var bottomPartBottomSheetView: some View {
        VStack {
            ZStack {
                bottomSheetBackGroundView
                ZStack {
                    VStack {
                        HStack {
                            Image(Constants.onImageName)
                            Spacer()
                            steperView
                            Spacer()
                            Image(Constants.unionImageName)
                        }
                        colorPikersAndTextView
                    }
                }
                .frame(width: UIScreen.main.bounds.width - Constants.bottomPartBottomSheetViewSpacingNumber)
            }
            .frame(height: 130)
        }
    }

    private var bottomSheetView: some View {
        VStack {
            topPartBottomSheetView
            bottomPartBottomSheetView
        }
        .frame(width: UIScreen.main.bounds.width - Constants.bottomSheetViewSpacingNumber, height: 430)
        .ignoresSafeArea(.all, edges: .bottom)
        .offset(y: UIScreen.main.bounds.height / Constants.halfScreenNumber)
        .offset(y: climateControlViewModel.bottomSheetCurrentOffsetY)
        .gesture(dragBottomSheetGesture)
    }

    // MARK: - Private Methods

    private func climateControlTextView(index: Int) -> some View {
        Text(climateControlViewModel.settingsClimate[index].settingName)
            .font(.title)
            .bold()
            .foregroundColor(Color(Constants.climateControlTextViewForegroundColor))
            .frame(width: 70)
    }

    private func climateControlButtonView(index: Int) -> some View {
        Button {
            climateControlViewModel.settingsClimate[index].isAction.toggle()
            climateControlViewModel.settingsIndex = index
            climateControlViewModel.isActive()
            climateControlViewModel.getTemperature()
        } label: {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [Color.white.opacity(0.15), Color.black.opacity(0.35)],
                        startPoint: .top,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 60)
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
                    .shadow(color: Color(Constants.buttonShadowColorDarkName).opacity(0.2), radius: 3)
                Image(systemName: climateControlViewModel.settingsClimate[index].settingsImageName)
                    .foregroundColor(
                        climateControlViewModel.settingsClimate[index]
                            .isAction ? Color(Constants.gradientBottomColorName) : .white
                    )
            }
        }
    }

    private func climateControlSliderView(index: Int) -> some View {
        NeumorphismSlider(value: Binding(get: {
            if climateControlViewModel.settingsClimate[index].isAction {
                climateControlViewModel.getTemperature()
                return climateControlViewModel.climateSliderValues[index]
            } else {
                return 0.0
            }
        }, set: { newValue in
            if climateControlViewModel.settingsClimate[index].isAction {
                climateControlViewModel.climateSliderValues[index] = newValue
                climateControlViewModel.getTemperature()
            } else {
                climateControlViewModel.climateSliderValues[index] = 0.0
                climateControlViewModel.getTemperature()
            }
        }), in: 0 ... Constants.maxSteperNumber, step: 1)
            .frame(width: 230, height: 50)
    }

    private func makeClimateGroupView(index: Int) -> some View {
        VStack {
            HStack(spacing: 10) {
                climateControlTextView(index: index)
                climateControlButtonView(index: index)
                climateControlSliderView(index: index)
            }
        }
        .padding(.vertical, 12)
    }
}

///
struct ContentViewreviews: PreviewProvider {
    static var previews: some View {
        ClimateControlView()
            .environment(\.colorScheme, .dark)
    }
}
