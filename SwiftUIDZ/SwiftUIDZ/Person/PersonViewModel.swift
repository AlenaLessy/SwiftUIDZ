//
//  PersonViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Вью модель экрана пользователя
final class PersonViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var currentPersonNumber = 0
    
    // MARK: - Private Properties
    
    private let persons = Person.getPersons()
    
    //MARK: - Public Methods
    
    func getPersonImageName() -> String {
        guard currentPersonNumber < persons.count else { return "" }
        return persons[currentPersonNumber].imageString
    }
    
    func getPersonName() -> String {
        guard currentPersonNumber < persons.count else { return "" }
        return persons[currentPersonNumber].name
    }
    
    func getPersonCityName() -> String {
        guard currentPersonNumber < persons.count else { return "" }
        return persons[currentPersonNumber].cityName
    }
    
    func getMessageCount() -> Int {
        guard currentPersonNumber < persons.count else { return 0 }
        return persons[currentPersonNumber].messageCount
    }
    
    func getNotificationCount() -> Int {
        guard currentPersonNumber < persons.count else { return 0 }
        return persons[currentPersonNumber].notificationCount
    }
}
