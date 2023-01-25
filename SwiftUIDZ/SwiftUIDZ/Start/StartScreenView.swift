//
//  ContentView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

/// Стартовый экран приложения
struct StartScreenView: View {
    
    @StateObject var startScreenViewModel = StartScreenViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("ONLINE FURNITURE STORE")
                /// одинаковые модификаторы вынести
                    .font(.system(size: 32, design: .default))
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(15)
                
                asyncImageView
                Spacer().frame(height: 100)
                
                getStartedButtonView
                
//                Button {
//                    print("")
//                } label: {
//                    Text("GET STARTED")
//
//                    /// одинаковые модификаторы вынести
//                        .font(.system(size: 32, design: .default))
//                        .bold()
//                        .foregroundColor(.white)
//                }
//                .frame(width: 270, height: 70)
//                .background( LinearGradient(colors: [Color.red, Color.red.opacity(0.3)], startPoint: .bottomTrailing, endPoint: .topLeading))
//                .cornerRadius(50)
                
                // label
                VStack(spacing: 0) {
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 20, design: .default))
                    
                    // навигация
                    NavigationLink(destination: LoginView(), isActive: $startScreenViewModel.issingInButtonPressed, label: { EmptyView()})
                    NavigationLink(destination: SelectFurnitureView(), isActive: $startScreenViewModel.isgetStartedPressed, label: { EmptyView()})
                    // button
                    Button {
                        startScreenViewModel.issingInButtonPressed = true
                    } label: {
                        Text("Sing in here")
                            .font(.system(size: 32, design: .default))
                            .bold()
                            .foregroundColor(.white)
                            .underline()
                    }
                    .frame(width: 270, height: 70)
                    
                }.offset(y: 60)
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                LinearGradient(colors: [Color.yellow, Color.red.opacity(0.8)], startPoint: .top, endPoint: .bottom)
            )
            
        }
    }
    
    private var getStartedButtonView: some View {
        RedGradientButtonView(action: {
            startScreenViewModel.isgetStartedPressed = true
        }, label: "GET STARTED", offset: 0)
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
                        .frame(width: 200, height: 200)
                case .failure(let error):
                    VStack {
                        Image(systemName: "questionmark")
                        Text(error.localizedDescription)
                            .font(.headline)
                    }
                @unknown default:
                    fatalError()
                }
            }
        }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartScreenView()
//    }
//}
