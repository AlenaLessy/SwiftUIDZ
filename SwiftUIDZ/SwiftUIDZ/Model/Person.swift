//
//  Person.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import Foundation

/// Пользователь
struct Person {
    
    /// Имя
    let name: String
    /// Имя фотографии
    let imageString: String
    /// Название города
    let cityName: String
    /// Количество сообщений
    var messageCount: Int
    /// Количество уведомлений
    var notificationCount: Int
    
    /// Массив пользователей
    static func getPersons() -> [Person] {
       [ Person(name: "Julia Rouz", imageString: "pr", cityName: "Berlin", messageCount: 3, notificationCount: 5)
         ]
    }
}
