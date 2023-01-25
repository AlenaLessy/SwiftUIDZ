//
//  SelectFurnitureViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import Foundation

/// Вью модель выбора мебели
final class SelectFurnitureViewModel: ObservableObject {
    
    @Published var currentIndex = 0
    @Published var lastDescriptionChar = ""
    @Published var descriptionText = ""
    
    private let furnitures = Furniture.getFurniture()
    
    
    init(currentIndex: Int = 0) {
        self.currentIndex = currentIndex
        getRandomIndexOfFurniture()
    }
    
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
        "$\(furnitures[currentIndex].price)"
    }
    
    func limitationCharsOfDescriptionTextEditor(totalChars: String) -> String {
        if totalChars.count <= 100 {
            lastDescriptionChar = totalChars
            return lastDescriptionChar
        } else {
            return lastDescriptionChar
        }
    }
    
    
}
