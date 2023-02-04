// TabBarView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Экран таббара
struct TabBarView: View {

    // MARK: - Private Constants
    
    private enum Constants {
        static let carIconName = "car"
        static let lightningIconName = "bolt"
        static let exploreIconIconName = "mappin"
        static let personIconName = "person.fill"
        static let emptyString = ""
    }
    
    // MARK: - Public Property
    
    @ObservedObject var startedViewModel: TabBarViewModel
    
    var body: some View {
        TeslaTabView(selection: $startedViewModel.selection, showTabBar: $startedViewModel.showTabBar) {
            ChargingView()
                .myTabItem {
                    TabItem(title: Constants.emptyString, icon: Constants.carIconName)
                }
                .opacity(startedViewModel.updateOneScreenOpacity)
            SettingsView(showTabBar: $startedViewModel.showTabBar)
                .myTabItem {
                    TabItem(title: Constants.emptyString, icon: Constants.lightningIconName)
                }
                .opacity(startedViewModel.updateTwoScreenOpacity)
            Color.black
                .myTabItem {
                    TabItem(title: Constants.emptyString, icon: Constants.exploreIconIconName)
                }
                .opacity(startedViewModel.updateThreeScreenOpacity)
            Color.black
                .myTabItem {
                    TabItem(title: Constants.emptyString, icon: Constants.personIconName)
                }
                .opacity(startedViewModel.updateFourScreenOpacity)
        }
    }
}
