//
//  ClimateControlView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 31.01.2023.
//

import SwiftUI

/// Вью - модель настроек системы кондиционирования
final class ClimateControlViewModel: ObservableObject {
    
    @Published var gradientColors = [Color("GradientBackgroundTop"), Color("GradientBackGroundBottom")]
    @Published var settingsIndex = 0
 
   
    @Published var settingsClimate = SettingsClimateModel.getSettings()
    
    @Published var climateSliderValues = [0.0, 0.0, 0.0, 0.0]
    
    @Published var isClimateControlEnabled = false
    @Published var bottomSheetCurrentOffsetY: CGFloat = 0
    @Published var bottomSheetLastOffsetY: CGFloat = 0
    @Published var bottomGradientColor: CGColor = CGColor(red: 47, green: 184, blue: 255, alpha: 1)
    
  
    @Published var topGradientColor: CGColor = CGColor(red: 158, green: 236, blue: 217, alpha: 1)
    
    // MARK: - Public Methods
    
//    func getSettingsName() -> String {
//        settingsClimate[settingsIndex].settingName
//    }
//
//    func getSettingsImageName() -> String {
//        settingsClimate[settingsIndex].settingsImageName
//    }
//
//    func getSettingsSliderMaxValue() -> Double {
//        settingsClimate[settingsIndex].sliderMaxValue
//    }
//
//    func toggleActionSettings(condition: Bool) {
//        settingsClimate[settingsIndex].isAction = condition
//    }
    
    func isActive() {
        if !settingsClimate[settingsIndex].isAction {
            climateSliderValues[settingsIndex] = 0
        }
    }
}
/// Настройки системы кондиционирования
struct ClimateControlView: View {

    // MARK: - Private Constants
    
    private enum Constants {
        static let gradientTopColorName = "GradientTop"
        static let gradientBottomColorName = "GradientBottom"
    }
    
   
    
 // MARK: - Public Properties
    
    @State var isSlider = 0.0
    @State var isrange = 0.0...15
    
    @Environment(\.presentationMode) var presentation
    @GestureState private var bottomSheetGestureOffsetValue = CGSize.zero
    @StateObject private var climateControlViewModel = ClimateControlViewModel()
  
    var dragBottomSheetGesture: some Gesture {
        DragGesture()
            .updating($bottomSheetGestureOffsetValue) { value, state, _ in
                state = value.translation
                onChangeBottomSheetOffset()
            }
            .onEnded { _ in
                withAnimation {
                    if -climateControlViewModel.bottomSheetCurrentOffsetY > 200 {
                        climateControlViewModel.bottomSheetCurrentOffsetY = -100
                    } else {
                        climateControlViewModel.bottomSheetCurrentOffsetY = 0
                    }
                    climateControlViewModel.bottomSheetLastOffsetY = climateControlViewModel.bottomSheetCurrentOffsetY
                            
                }
            }
    }
    private func onChangeBottomSheetOffset() {
        DispatchQueue.main.async {
            climateControlViewModel.bottomSheetCurrentOffsetY = bottomSheetGestureOffsetValue.height + climateControlViewModel.bottomSheetLastOffsetY
        }
    }
    
    private func makeClimateGroupView(index: Int) -> some View {
        VStack {
            
            HStack(spacing: 10) {
                Text(climateControlViewModel.settingsClimate[index].settingName)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("buttonGr1"))
                    .frame(width: 70)
                //  .offset(x: -10)
                
                Button {
                    climateControlViewModel.settingsClimate[index].isAction.toggle()
                    climateControlViewModel.settingsIndex = index
                    climateControlViewModel.isActive()
                    
                } label: {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [Color.white.opacity(0.15), Color.black.opacity(0.35)], startPoint: .top, endPoint: .bottomTrailing))
                            .frame(width: 60)
                            .overlay(Circle().stroke(LinearGradient(colors: [Color.black.opacity(0.6), Color.white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1))
                        
                            .padding(.all, 0)
                            .background(Circle().fill(Color("back2").opacity(0)))
                        
                            .shadow(color: Color("ligth").opacity(0.2), radius: 3, x: 4)
                            .shadow(color: Color("dark").opacity(0.2), radius: 3)
                        Image(systemName: climateControlViewModel.settingsClimate[index].settingsImageName)
                            .foregroundColor(climateControlViewModel.settingsClimate[index].isAction ? Color("GradientBottom") : .white)
                    }
                }

              
                
                LockerSlider(value: Binding(get: {
                    if climateControlViewModel.settingsClimate[index].isAction {
                     return   climateControlViewModel.climateSliderValues[index]
                    } else {
                     return   0.0
                    }
                }, set: { newValue in
                    if climateControlViewModel.settingsClimate[index].isAction {
                        climateControlViewModel.climateSliderValues[index] = newValue
                    } else {
                        climateControlViewModel.climateSliderValues[index] = 0.0
                    }
                }), in: 0...15, step: 1)
                    .frame(width: 230, height: 50)
            }
        }
        .padding(.vertical, 12)
    }
    
    var body: some View {
       // NavigationView {
            ZStack {
                BackgroundStackView(colors: climateControlViewModel.gradientColors) {
                VStack(spacing: 10) {
                    HStack(spacing: 55) {
                        backButtonView
                        Text("CLIMATE")
                            .font(.system(size: 20))
                            .bold()
                            .font(.title2)
                        settingsButtonView
                    }
                    .padding(.top, 20)
                    temperatureIndicatorView
                    DisclosureGroup {
                        ForEach(0 ..< 4) { index in
                            makeClimateGroupView(index: index)
                        }
                    } label: {
                        Text("Настройки")
                    }
                    .foregroundColor(.white)
                    .tint(.white)
                  //  .frame(width: 450)
                    .padding(.horizontal, 10)
                    bottomSheetView
                    Spacer()
                }
                
            }
           
        }
            .navigationBarBackButtonHidden()
        
        
    }
    
    private var toolbarTitleTextView: some View {
        Text("CLIMATE")
    }
    
    private var backButtonView: some View {
        СonvexCircleButtonView(actionHandler: {
            presentation.wrappedValue.dismiss()
        }, iconName: "chevron").tint(.white)
    }
    
    private var settingsButtonView: some View {
        СonvexCircleButtonView(actionHandler: {
            print("")
        }, iconName: "settings").tint(.white)
    }
        
//    private var gradientView: GradientsBackgroundStackView {
//
//
// GradientsBackgroundStackView(fromGradientColors: welcomeViewModel.lockGradientColors, toGradientColors: welcomeViewModel.unlockGradientColors, progress: welcomeViewModel.gradientProgress)
//    }
    
    private var temperatureIndicatorView: some View {
        return ZStack {
            Circle()
                .fill(LinearGradient(colors: [Color.black.opacity(0.3), Color.white.opacity(0.1)], startPoint: .top, endPoint: .bottomTrailing))
                .frame(width: 140)
                .overlay(Circle().stroke(LinearGradient(colors: [Color("RoundBack1"), Color("RoundBack2")], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 28))
                .background(Circle().fill(Color("back2")))
                .shadow(color: Color("ligth").opacity(0.1), radius: 25, x: -17, y: -15)
                .shadow(color: Color("dark").opacity(0.5), radius: 20, x: 15, y: 15)
            Circle()
                .fill(.clear)
                .frame(width: 110)
            
                .overlay(Circle().stroke(LinearGradient(colors: [Color(.black).opacity(0.2), Color(.white).opacity(0.1), Color(.black).opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5))
            
            Circle()
                .trim(from: 0, to: climateControlViewModel.isClimateControlEnabled ? climateControlViewModel.climateSliderValues[climateControlViewModel.settingsIndex] : 0)
                .stroke(LinearGradient(colors: [Color(climateControlViewModel.bottomGradientColor), Color(climateControlViewModel.topGradientColor)], startPoint: .top, endPoint: .bottomTrailing), lineWidth: 15)
                .frame(width: 168)
                .rotationEffect(.degrees(-90))
                .shadow(color: Color(climateControlViewModel.bottomGradientColor).opacity(0.5), radius: 3, x: -3, y: -3)
                .shadow(color: Color(climateControlViewModel.topGradientColor).opacity(0.5), radius: 3, x: 3, y: 3)
        }
    }
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color(Constants.gradientTopColorName), Color(Constants.gradientBottomColorName)], startPoint: .bottom, endPoint: .top)
    }
    
    private var bottomSheetView: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(gradient).opacity(0.15)
                
                ZStack {
                    HStack {
                        VStack(spacing: -10) {
                            HStack {
                                Text("A/C is ON")
                                    .font(Font.system(size: 18))
                                    .bold()
                                Spacer()
                            }
                            HStack {
                                Text("Tap to turn off or swipe up for a fast setup")
                                    .font(Font.system(size: 15, weight: .semibold))
                                    .foregroundColor(.gray)
                                Spacer()
                                СonvexCircleButtonView(actionHandler: {
                                    climateControlViewModel.isClimateControlEnabled.toggle()
                                }, iconName: "on")
                            }
                        }
                       
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 20)
                
                
                VStack {
                    Capsule()
                        .fill(.black)
                        .frame(width: 70, height: 5)
                        .padding(.top)
                    Spacer()
                }
            }
            .frame(height: 100)
                
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(gradient).opacity(0.15)
                    
                    
                    ZStack {
                        VStack {
                            HStack {
                                Image("on")
                                Spacer()
                                HStack {
                                    Button {
                                        print("")
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .tint(.white)
                                    }
                                    Text("50 C")
                                        .font(.title3)
                                    Button {
                                        print("")
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                            .tint(.white)
                                    }
                                }
                                Spacer()
                                Image("Union")
                            }
                            HStack {
                                Text("On")
                                Spacer()
                                ColorPicker("Color one", selection: $climateControlViewModel.topGradientColor)
                                    .frame(width: 80)
                                Spacer()
                                ColorPicker("Color two", selection: $climateControlViewModel.bottomGradientColor)
                                    .frame(width: 80)
                                Spacer()
                                Text("Vent")
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 70)
                    
                }
                .frame(height: 100)
            }
            .frame(width: UIScreen.main.bounds.width - 10, height: 200)
            .ignoresSafeArea(.all, edges: .bottom)
            .offset(y: UIScreen.main.bounds.height / 2 - 10)
            .gesture(dragBottomSheetGesture)
            }
       
        }
    }


struct ContentViewreviews: PreviewProvider {
    static var previews: some View {
        ClimateControlView()
            .environment(\.colorScheme, .dark)
    }
}
