//
//  KeyBoardResponder.swift
//  SwiftUIDZ
//
//  Created by Алена Панченко on 25.01.2023.
//

import SwiftUI

/// Сдвиг элементов с появлением клавиатуры
final class KeyboardResponder: ObservableObject {
    
    // MARK: - Private Constants
    
    private enum Constants {
        static let zeroFloatNumber: CGFloat = 0
    }
    
    // MARK: - Private Properties
    
    @Published private(set) var currentHeight: CGFloat = Constants.zeroFloatNumber
    
    private var notificationCenter: NotificationCenter
    
    // MARK: - Initializers
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(
            self,
            selector: #selector(keyBoardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(keyBoardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Public Methods
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue
        )?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = Constants.zeroFloatNumber
    }
}
