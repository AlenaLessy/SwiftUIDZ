//
//  NotificationsViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Вью модель экрана уведомлений
final class NotificationsViewModel: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let emptyString = ""
    }
    
    // MARK: - Public Properties
    
    @Published var isToggleOn = false
    @Published var isUpdateSettingsButtonPressed = false
    
    var notificationsCount: Int {
        notifications.count
    }
    
    // MARK: - Private Properties
    
    private var notifications = FurnitureNotification.getNotifications()
    
    
    // MARK: - Public Methods
    
    func getNotificationName(index: Int) -> String {
        guard index < notifications.count else { return "" }
        return notifications[index].name
    }
    
    func getNotificationState(index: Int) -> Bool {
        guard index < notifications.count else { return false }
        return notifications[index].isNotificationState
    }
    
    func updateNotificationState(index: Int, value: Bool) {
        guard index < notifications.count else { return }
        notifications[index].isNotificationState = value
    }
    
    func getNotificationDescription(index: Int) -> String {
        guard index < notifications.count else { return Constants.emptyString }
        return notifications[index].description
    }
}
