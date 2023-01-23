//
//  Country.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 22.01.2023.
//

import Foundation

/// Страна впн
struct Country {
    /// Имя страны
    let name: String
    /// Имя картинки с флагом страны
    let flagImageName: String
    /// IP - адрес
    let iP: String
    
    static func getCountries() -> [Country] {
        [Country(name: "Болгария", flagImageName: "bolgar", iP: "5.188.6.201"),
         Country(name: "Германия", flagImageName: "germany", iP: "3.151.9.243"),
         Country(name: "Люксембург", flagImageName: "luxemburg", iP: "1.425.3.151"),
         Country(name: "Сингапур", flagImageName: "singapure", iP: "9.353.1.735")
        ]
    }
}
