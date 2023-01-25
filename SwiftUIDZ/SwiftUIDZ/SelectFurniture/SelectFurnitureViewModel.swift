//
//  SelectFurnitureViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import Foundation

/// Вью модель выбора мебели
final class SelectFurnitureViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let startIndexNumber = 0
        static let dollarSymbolValue = "$"
        static let maxCharValue = 100
    }
    
    // MARK: - Public Properties
    
    @Published var currentIndex = Constants.startIndexNumber
    @Published var lastDescriptionChar = Constants.emptyString
    @Published var descriptionText = Constants.emptyString
    
    // MARK: - Private Properties
    
    private let furnitures = Furniture.getFurniture()
    
    // MARK: - Initializers
    
    init(currentIndex: Int = Constants.startIndexNumber) {
        self.currentIndex = currentIndex
        getRandomIndexOfFurniture()
    }
    
    // MARK: - Private Methods
    
    func getRandomIndexOfFurniture() {
        currentIndex = Int(arc4random_uniform(UInt32(furnitures.count)))
    }
    
    func getRandomFurnitureImage() -> String {
        furnitures[currentIndex].imageName
    }
    
    func getRandomFurnitureName() -> String {
        furnitures[currentIndex].name
    }
    
    func getRandomFurniturePrice() -> String {
        "\(Constants.dollarSymbolValue)\(furnitures[currentIndex].price)"
    }
    
    func limitationCharsOfDescriptionTextEditor(totalChars: String) -> String {
        if totalChars.count <= Constants.maxCharValue {
            lastDescriptionChar = totalChars
            return lastDescriptionChar
        } else {
            return lastDescriptionChar
        }
    }
}
