//
//  VPNTabView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 17.01.2023.
//

import SwiftUI

///  Таб вью приложения VPN
struct VPNTabView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let lockSystemImageName = "lock"
        static let listSystemImageName = "list.bullet"
        static let basketSystemImageName = "basket"
        static let vPNLabelTitleText = "VPN"
        static let purchseLabelTitleText = "Purchse"
        static let basketLabelTitleText = "Basket"
        
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack {
            TabView {
                VPNView()
                    .tabItem {
                        Label(Constants.vPNLabelTitleText, systemImage: Constants.lockSystemImageName)
                    }
                RatesView()
                    .tabItem {
                        Label(Constants.purchseLabelTitleText, systemImage: Constants.listSystemImageName)
                    }
                BasketView()
                    .badge(ratesViewModel.badge)
                    .tabItem {
                        Label(Constants.basketLabelTitleText, systemImage: Constants.basketSystemImageName)
                    }
            }
        }
        .environmentObject(ratesViewModel)
    }
    
    // MARK: - Private Properties
    
    @StateObject private var ratesViewModel = RatesViewModel()
}

/// Представление тейбл вью
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VPNTabView()
    }
}

