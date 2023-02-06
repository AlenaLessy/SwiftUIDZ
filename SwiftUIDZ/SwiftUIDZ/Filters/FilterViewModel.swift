//
//  FilterViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 05.02.2023.
//

import SwiftUI

/// Вью модель экрана фильтра
final class FilterViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var currentColor: Color = .pink
    @Published var sliderPosition: ClosedRange<Float> = 500...5000
    
   // MARK: - Private Properties
    
    private let furnitures = Furniture.getFurniture()
    
    private let colors: [Color] = [ .white, .black, .gray, .purple, .yellow, .red, .purple.opacity(0.5), .blue, .cyan, .green, .orange, .brown, .indigo, .mint, .pink, .yellow.opacity(0.5), .pink.opacity(0.4), .green.opacity(0.4), .orange.opacity(0.5), .blue.opacity(0.3)
    ]
    
    // MARK: - Public Methods
    
    func getFurnitureImageNames() -> [String] {
        var imageNames: [String] = []
        for index in 0 ..< furnitures.count {
            imageNames.append(furnitures[index].imageName)
        }
        return imageNames
    }
    
    func getColors() -> [Color] {
        colors
    }
}
