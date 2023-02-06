//
//  TabBarView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Таб бар приложения
struct TabBarView: View {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let windowSystemImageName = "window.awning"
        static let bagSystemImageName = "bag.fill"
        static let personSystemImageName = "person"
        static let gearshapeSystemImageName = "gearshape.fill"
        static let ellipsisSystemImageName = "ellipsis"
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        ZStack {
            GradientNavigationView()
            VStack {
                TabView {
                    SelectFurnitureView()
                        .tabItem {
                            Label(Constants.emptyString, systemImage: Constants.windowSystemImageName)
                        }
                    GoodsView()
                        .tabItem {
                            Label(Constants.emptyString, systemImage: Constants.bagSystemImageName)
                        }
                    PersonView()
                        .tabItem {
                            Label(Constants.emptyString, systemImage: Constants.personSystemImageName)
                        }
                    SelectFurnitureView()
                        .tabItem {
                            Label(Constants.emptyString, systemImage: Constants.gearshapeSystemImageName)
                        }
                    SelectFurnitureView()
                        .tabItem {
                            Label(Constants.emptyString, systemImage: Constants.ellipsisSystemImageName)
                        }
                }
            }
            .padding(.top, 10)
        }
    }
}

struct TabBarView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
