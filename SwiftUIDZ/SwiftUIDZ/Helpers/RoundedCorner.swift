//
//  RoundedCorner.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import SwiftUI

/// Закругление угла
struct RoundedCorner: Shape {
    
    // MARK: - Public Properties
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    // MARK: - Public Methods
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
