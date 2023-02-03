//
//  TabItem.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 03.02.2023.
//

import SwiftUI

/// Элемент таб бара
struct TabItem: Identifiable, Equatable {
    /// Id элемента таб бара
    var id = UUID()
    /// Имя элемента таб бара
    let title: String
    /// Изображение элемента таб бара
    let icon: String
}
