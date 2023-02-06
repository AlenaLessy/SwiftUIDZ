//
//  GoodsViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 05.02.2023.
//

import SwiftUI

/// Вью модель экрана покупок
final class GoodsViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
        static let discountFactorNumber = 1.3
    }
    
    // MARK: - Public Properties
    
    @Published var searchText = Constants.emptyString
    @Published var summ = 0
    @Published var isFilterButtonPressed = false
    
    var furnituresCount: Int {
        furnitures.count
    }
    
    // MARK: - Private Properties
    
    @Published private var furnitures = Furniture.getFurniture()
    
    // MARK: - Public Methods
    
    func getFurnitureImageName(index: Int) -> String {
        guard index < furnitures.count else { return Constants.emptyString }
        return furnitures[index].imageName
    }
    
    func getFurnitureName(index: Int) -> String {
        guard index < furnitures.count else { return Constants.emptyString }
        return furnitures[index].name
    }
    
    func getFurnitureCount(index: Int) -> String {
        guard index < furnitures.count else { return Constants.emptyString }
        return "\(furnitures[index].furnitureCount)"
    }
    
    func updateAddFurnitureCount(index: Int) {
        guard index < furnitures.count else { return }
        furnitures[index].furnitureCount += 1
        furnitures[index].totalAmount += furnitures[index].price
        summ += furnitures[index].price
    }
    
    func updateRemoveFurnitureCount(index: Int) {
        guard index < furnitures.count,
        furnitures[index].furnitureCount > 0
        else { return }
        furnitures[index].furnitureCount -= 1
        furnitures[index].totalAmount -= furnitures[index].price
        summ -= furnitures[index].price
    }
    
    func getFurniturePrice(index: Int) -> String {
        guard index < furnitures.count else { return Constants.emptyString }
        return "\(furnitures[index].price)"
    }
    
    func getOldFurniturePrice(index: Int) -> String {
        guard index < furnitures.count else { return Constants.emptyString }
        return "\(Int(Double(furnitures[index].price) * Constants.discountFactorNumber))"
    }
}
