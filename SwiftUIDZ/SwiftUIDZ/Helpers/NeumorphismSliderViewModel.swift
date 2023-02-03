// NeumorphismSliderViewModel.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью модель слайдера в стиле неоморфизма
final class NeumorphismSliderViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var ratio: CGFloat = 0
    @Published var startX: CGFloat?

    func updateStatus(value: DragGesture.Value, proxy: GeometryProxy, length: CGFloat) {
        guard startX == nil else { return }
        let delta = value.startLocation.x - (proxy.size.width - length) * ratio
        startX = (length < value.startLocation.x && delta > 0) ? delta : value.startLocation.x
    }
}
