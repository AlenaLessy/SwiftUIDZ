//
//  VPNViewModel.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 22.01.2023.
//

import SwiftUI

/// Вью модель экрана подключения ВПН
final class VPNViewModel: ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var isOnToogle = false
    @Published var selectionCountryNumber = 0
    
    // MARK: - Private Properties
    
    private var countries = Country.getCountries()
    
    // MARK: - Public Methods
    
    func getFlagCountryName() -> String {
        countries[selectionCountryNumber].flagImageName
    }
    
    func getCountryName() -> String {
        countries[selectionCountryNumber].name
    }
    
    func getCountryNames() -> [String] {
        var countryNames = [String]()
        countries.forEach { countryNames.append($0.name) }
        return countryNames
    }
    
    func getIPAddress() -> String {
        countries[selectionCountryNumber].iP
    }
}
