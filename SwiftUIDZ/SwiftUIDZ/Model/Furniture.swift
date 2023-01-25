//
//  Furniture.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 23.01.2023.
//

import Foundation

/// Мебель
struct Furniture {
    
    /// Название
    let name: String
    /// Адрес картинки
    let imageURLString: String
    /// Имя картинки
    let imageName: String
    /// Цена
    let price: String
    
    /// Массив с мебелью
    static func getFurniture() -> [Furniture] {
       [ Furniture(name: "Софа", imageURLString: "https://i.postimg.cc/nr6RgPGW/icons8-sofa-100.png", imageName: "1", price: "55"),
         Furniture(name: "Кровать", imageURLString: "https://i.postimg.cc/htSvCfTR/bedRoom.png", imageName: "2", price: "96"),
         Furniture(name: "Кресло", imageURLString: "https://i.postimg.cc/y8vd2syg/kreslo.png", imageName: "3", price: "35"),
         Furniture(name: "Буфет", imageURLString: "https://i.postimg.cc/mkLQMMCX/buffet.png", imageName: "4", price: "78"),
         Furniture(name: "Cтолик", imageURLString: "https://i.postimg.cc/B6G5SR6G/icons8-coffee-table-100.png", imageName: "5", price: "46"),
         Furniture(name: "Шкаф", imageURLString: "https://i.postimg.cc/MpNb4nJH/schkaf.png", imageName: "6", price: "63"),
         Furniture(name: "Стол", imageURLString: "https://i.postimg.cc/W36GhSFq/stol.png", imageName: "7", price: "39"),
         Furniture(name: "Стул", imageURLString: "https://i.postimg.cc/s2W9R33c/stul.png", imageName: "8", price: "22"),
         ]
    }
}
