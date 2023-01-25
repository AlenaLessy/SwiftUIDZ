//
//  StartScreenViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 24.01.2023.
//

import Foundation

/// Вью модель стартового экрана
final class StartScreenViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var issingInButtonPressed = false
    @Published var isgetStartedPressed = false
    
    // MARK: - Private Properties
    
    private let furnitures = Furniture.getFurniture()
    
    // MARK: - Public Methods
    
    func getRandomFurnitureImageString() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(furnitures.count)))
        return furnitures[randomIndex].imageURLString
    }
}
