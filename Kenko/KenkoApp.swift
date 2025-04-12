//
//  APIDemoApp.swift
//  APIDemo
//
//  Created by apple on 16/03/25.
//

import SwiftUI

@main
struct KenkoApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                CustomTabView()
            } else {
                OnboardingScreen(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
    }
}
