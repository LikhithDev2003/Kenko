import SwiftUI

struct OnboardingScreen: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentStep = 0
    private let totalSteps = 5

    var body: some View {
        VStack(spacing: 24) {
            // MARK: Top Bar with Back & Step Count
            HStack {
                
                if currentStep > 0 {
                    Button(action: {
                        currentStep -= 1
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }

                Spacer()

                Text("\(currentStep + 1)/\(totalSteps)")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)

            // MARK: Step Progress Indicators
            HStack(spacing: 8) {
                ForEach(0..<totalSteps, id: \.self) { index in
                    Rectangle()
                        .fill(index <= currentStep ? Color(hex: "#58A7B5") : Color.gray.opacity(0.4))
                        .frame(height: 3)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal)

            // MARK: Content Area
            StepContentView(step: currentStep, hasCompletedOnboarding: $hasCompletedOnboarding) {
                if currentStep < totalSteps - 1 {
                    currentStep += 1
                }
            }

            Spacer(minLength: 0)
        }
        .background(Color.black.ignoresSafeArea())
    }
}
