//
//  TabBarView.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Таб бар приложения
struct TabBarView: View {
    
    // MARK: - Public Properties
    
    var body: some View {
        ZStack {
            GradientNavigationView()
            VStack {
                TabView {
                    SelectFurnitureView()
                        .tabItem {
                            Label("", systemImage: "window.awning")
                        }
                    GoodsView()
                        .tabItem {
                            Label("", systemImage: "bag.fill")
                        }
                    PersonView()
                        .tabItem {
                            Label("", systemImage: "person")
                        }
                    SelectFurnitureView()
                        .tabItem {
                            Label("", systemImage: "gearshape.fill")
                        }
                    SelectFurnitureView()
                        .tabItem {
                            Label("", systemImage: "ellipsis")
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
