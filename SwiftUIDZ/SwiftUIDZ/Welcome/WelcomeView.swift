//
//  WelcomeView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 30.01.2023.
//

import SwiftUI

/// Вью модель экрана приветствия
final class WelcomeViewModel: ObservableObject {
    
    private enum Constants {
        static let openCarButtonTagNumber = 1
        static let closeText = "Закрыть"
        static let openText = "Открыть"
        static let lockOpenFillSystemImageName = "lock.open.fill"
        static let lockFillSystemImageName = "lock.fill"
        static let closeCarImageName = "image 46"
        static let openCarImageName = "image 47"
    }
    
    @Published var isLock = false
    
    // MARK: - Public Properties
    
    @Published var buttonTagSelected = 0
    @Published var isChangeImage = false
    @Published var gradientProgress: CGFloat = 0
    @Published var isSettingsButtonPressed = false
    
 
    
    
    // MARK: - Public Methods
    
    func isOpenCarButtonPressed() -> Bool {
        if buttonTagSelected == Constants.openCarButtonTagNumber {
            return true
        } else {
            return false
        }
    }
    
    func getCarImageName() -> String {
        isChangeImage ? Constants.closeCarImageName : Constants.openCarImageName
    }
    
    func getLockTitleText() -> String {
        isChangeImage ? Constants.closeText : Constants.openText
    }
        
    func getLockIconName() -> String {
        isChangeImage ? Constants.lockOpenFillSystemImageName : Constants.lockFillSystemImageName
    }
    
    func gradientColor() {
        if isChangeImage {
            gradientProgress = 0
        } else {
            gradientProgress = 1
        }
    }
    
    @Published var lockGradientColors = [Color("back11"), Color("back12"), Color("back13"), Color("back14")]
    
 
    
    @Published var unlockGradientColors = [Color("GradientBackgroundTop"), Color("GradientBackgroundTop"), Color("GradientBackGroundBottom"), Color("GradientBackGroundBottom")]
    
    // MARK: - Public Methods
    
    func getLockGradientColors() -> [Color] {
        if isChangeImage {
          return unlockGradientColors
        } else {
          return lockGradientColors
        }
    }
}


/// Экран приветствия
struct WelcomeView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let settingsImageName = "settings"
        static let hiText = "Hi"
        static let welcomeBackText = "Welcome Back"
        static let closeCarImageName = "image 46"
        static let openCarImageName = "image 47"
        static let gradientTopColorName = "GradientTop"
        static let gradientBottomColorName = "GradientBottom"
    }
    
    @StateObject private var welcomeViewModel = WelcomeViewModel()
    
 // MARK: - Public Properties
    
    var body: some View {
        NavigationView {
            ZStack {
                gradientView
                VStack(spacing: 20) {
                    Spacer(minLength: 0)
                    HStack {
                        
                        NavigationLink(destination: SettingsView(), isActive: $welcomeViewModel.isSettingsButtonPressed) {}
                        СonvexCircleButtonView(actionHandler: {
                            welcomeViewModel.isSettingsButtonPressed = true
                        }, iconName: Constants.settingsImageName)
                        .offset(x: 130, y: -30)
                    }
                       
                    
                    Text(Constants.hiText)
                        .foregroundColor(welcomeViewModel.isChangeImage ? .gray : .black)
                        .font(.system(size: 20))
                        .font(.title)
                        .bold()
                    
                    Text(Constants.welcomeBackText)
                        .foregroundColor(welcomeViewModel.isChangeImage ? .white : .black)
                        .font(.system(size: 40))
                        .bold()
                    Image(welcomeViewModel.getCarImageName())
                        .resizable()
                        .frame(width: 407, height: 330)
                        .offset(y: welcomeViewModel.isChangeImage ? 20 : -30)
                    closeCarControlView
                    Spacer(minLength: 50)
                    
                    
                }
            }
        }
    }
        
    private var closeCarControlView: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(Color("buttonBackground").opacity(0.5))
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
////                .fill(Color("buttonBackground"))
//               .fill(Color.black.opacity(0))
//                .frame(width: 165, height: 79)
//               // .overlay(RoundedRectangle(cornerRadius: 50).stroke(LinearGradient(colors: [Color.black.opacity(0.6), Color.white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.8))
//
//                .padding(.all, 0)
//                .background(RoundedRectangle(cornerRadius: 50).fill(Color(.red)))
//                .shadow(color: Color(.white).opacity(1), radius: 10, x: -6, y: -6)
//                .shadow(color: Color(.black).opacity(0.5), radius: 10, x: 6, y: 6)
//
//
            HStack(spacing: 10) {
                Text(welcomeViewModel.getLockTitleText())
                    .bold()
                
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
                        Text("")
                    } icon: {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [Color.white.opacity(0.15), Color.black.opacity(0.35)], startPoint: .top, endPoint: .bottomTrailing))
                                .frame(width: 44)
                                .overlay(Circle().stroke(LinearGradient(colors: [Color.black.opacity(0.6), Color.white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1))

                                .padding(.all, 0)
                                .background(Circle().fill(Color("back2").opacity(0)))
                            
                                .shadow(color: Color("ligth").opacity(0.2), radius: 3, x: 4)
                                .shadow(color: Color("dark").opacity(0.2), radius: 3)
                            Image(systemName: welcomeViewModel.getLockIconName())
                                .tint(gradient)
                        }
                    }
                }
                .offset(x: 5)
            }
        }
        .frame(width: 165, height: 79)

    }
    
    private var gradientView: GradientsBackgroundStackView {
 GradientsBackgroundStackView(fromGradientColors: welcomeViewModel.lockGradientColors, toGradientColors: welcomeViewModel.unlockGradientColors, progress: welcomeViewModel.gradientProgress)
    }
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color(Constants.gradientTopColorName), Color(Constants.gradientBottomColorName)], startPoint: .bottom, endPoint: .top)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environment(\.colorScheme, .dark)
    }
}
