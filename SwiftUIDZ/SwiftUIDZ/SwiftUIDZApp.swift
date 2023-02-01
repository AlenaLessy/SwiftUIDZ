// SwiftUIDZApp.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

@main
struct SwiftUIDZApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environment(\.colorScheme, .dark)
        }
    }
}
