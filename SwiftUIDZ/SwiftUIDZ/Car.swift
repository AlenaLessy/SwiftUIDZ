//
//  Car.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 18.01.2023.
//

import Foundation

/// Машинка
struct Car {
    /// Название машинки
    let name: String
    /// Название фотографии машинки
    let imageName: String
    /// Тонировочка
    let toning: String
    /// Мощность двигателя
    let enginePower: Int
    /// Стоимость
    var price: Int
    
    
    static func getCars() -> [Car] {
        [
            Car(name: "Пятера",
                imageName: "11",
                toning: "Аквариум",
                enginePower: 74,
                price: 25000),
            Car(name: "Не пешком",
                imageName: "22",
                toning: "Гаишники попутают",
                enginePower: 82,
                price: 30000),
            Car(name: "Дедушкина",
                imageName: "33",
                toning: "Аквариум",
                enginePower: 123,
                price: 15000),
            Car(name: "Феррари",
                imageName: "44",
                toning: "Аквариум",
                enginePower: 162,
                price: 100000)
        ]
    }
}
