//
//  AppState.swift
//  Re_Note
//
//  Created by apple on 10/04/25.
//


import SwiftUI
import Combine

class AppState: ObservableObject {
    static let shared = AppState()

    @Published var isTabBarVisible: Bool = true
}
