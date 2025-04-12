//
//  publishers.swift
//  APIDemo
//
//  Created by apple on 06/04/25.
//
import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var isKeyboardVisible = false
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        let keyboardWillShow = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }

        let keyboardWillHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }

        Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .receive(on: RunLoop.main)
            .assign(to: \.isKeyboardVisible, on: self)
            .store(in: &cancellableSet)
    }
}

