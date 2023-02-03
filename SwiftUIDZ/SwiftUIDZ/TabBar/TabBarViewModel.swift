//
//  TabBarViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import SwiftUI

/// Вью модель таб бара
final class TabBarViewModel: ObservableObject {
    // MARK: - Public Property
    
    @Published var selection = 0
    @Published var showTabBar = true
    
    var updateOneScreenOpacity: Double {
        selection == 0 ? 1 : 0
    }
    
    var updateTwoScreenOpacity: Double {
        selection == 1 ? 1 : 0
    }
    
    var updateThreeScreenOpacity: Double {
        selection == 2 ? 1 : 0
    }
    
    var updateFourScreenOpacity: Double {
        selection == 3 ? 1 : 0
    }
}
