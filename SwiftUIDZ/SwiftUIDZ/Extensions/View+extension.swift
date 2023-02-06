//
//  View+extension.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import SwiftUI

/// Модификатор закругления 1 угла
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

/// Сбор вью
extension UIView {
        func allSubviews() -> [UIView] {
            var res = self.subviews
            for subview in self.subviews {
                let riz = subview.allSubviews()
                res.append(contentsOf: riz)
            }
            return res
        }
    }

/// Сокрытие таб бара
extension View {
    func showTabBar() -> some View {
        return self.modifier(ShowTabBar())
    }
    func hiddenTabBar() -> some View {
        return self.modifier(HiddenTabBar())
    }
}
