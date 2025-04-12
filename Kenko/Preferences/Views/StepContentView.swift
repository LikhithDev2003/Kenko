//
//  StepContentView.swift
//  APIDemo
//
//  Created by apple on 01/04/25.
//
import SwiftUI

struct StepContentView: View {
    let step: Int
    @Binding var hasCompletedOnboarding: Bool
    let onContinue: () -> Void
    @StateObject private var viewModel = PreferencesViewModel()

    var body: some View {
        switch step {
        case 0:
            StepOneView(onContinue: onContinue, viewModel: viewModel)
        case 1:
            StepTwoView(onContinue: onContinue, viewModel: viewModel)
        case 2:
            StepThreeView(onContinue: onContinue, viewModel: viewModel)
        case 3:
            StepFourView(onContinue: onContinue, viewModel: viewModel)
        case 4:
            StepFiveView(onContinue: onContinue, viewModel: viewModel, hasCompletedOnboarding: $hasCompletedOnboarding)
        default:
            EmptyView()
        }
    }
}
