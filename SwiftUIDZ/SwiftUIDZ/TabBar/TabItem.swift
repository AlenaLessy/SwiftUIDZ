// TabItem.swift
// Copyright © RoadMap. All rights reserved.

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
