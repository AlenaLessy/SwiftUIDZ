//
//  Notification.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import Foundation

/// Уведомления
struct FurnitureNotification {
    
    /// Имя уведомления
    let name: String
    /// Описание уведомления
    let description: String
    /// Состояние уведомления
    var isNotificationState: Bool

    
    /// Массив пользователей
    static func getNotifications() -> [FurnitureNotification] {
       [ FurnitureNotification(name: "Product updates", description: "Stair lifts the freedom of your home", isNotificationState: true),
         FurnitureNotification(name: "Comments", description: "Advertisin relation ships vs business", isNotificationState: false),
         FurnitureNotification(name: "Offer updates", description: "A right media mix can make", isNotificationState: true),
         FurnitureNotification(name: "Notifications", description: "Creating remarkable poster prints", isNotificationState: false)
         ]
    }
}
