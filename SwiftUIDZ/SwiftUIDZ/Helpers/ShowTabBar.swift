//
//  ShowTabBar.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 04.02.2023.
//

import SwiftUI

/// Проверка есть ли таб бар
struct Tool {
    
    // MARK: - Public Methods
    
    static func showTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = false
            }
        })
    }
    
    static func hiddenTabBar() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
            if let view = v as? UITabBar {
                view.isHidden = true
            }
        })
    }
}

/// Показать таб бар
struct ShowTabBar: ViewModifier {
    
    // MARK: - Public Methods
    
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.showTabBar()
        }
    }
}

/// Скрыть таб бар
struct HiddenTabBar: ViewModifier {
    
    // MARK: - Public Methods
    
    func body(content: Content) -> some View {
        return content.padding(.zero).onAppear {
            Tool.hiddenTabBar()
        }
    }
}
