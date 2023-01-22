//  ActivityViewController.swift
//  SwiftUIDZ
//  Created by Алена Панченко on 18.01.2023.

import Foundation
import SwiftUI

/// Активити вью контроллер
struct ActivityViewController: UIViewControllerRepresentable {
    // MARK: - Public Properties
    var items: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    // MARK: - Public Methods
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: items,
                                        applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityViewController>) {
    }
}
