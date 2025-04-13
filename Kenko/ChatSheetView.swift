//
//  ChatSheetView.swift
//  Kenko
//
//  Created by apple on 14/04/25.
//


import SwiftUI

struct ChatSheetView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: WorkoutViewModel  // ⬅️ Injected
    var mealViewModel: MealViewModel? = nil
    @State private var currentStep = 0
    @State private var responses: [String] = Array(repeating: "", count: 3)
    @FocusState private var isTextFieldFocused: Bool
    var isFromMealScreen: Bool = false
    
    private var questions: [String] {
        isFromMealScreen
            ? ["Do you have anything else to say?"]
            : ["How is your sleep quality yesterday?",
               "Do you have any injuries?",
               "Do you have anything else to say?"]
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray.opacity(0.4))
                .frame(width: 80, height: 5)
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(0...currentStep, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(questions[index])
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.white)
                            
                            if index < currentStep {
                                Text(responses[index])
                                    .padding(8)
                                    .background(Color(hex: "#2B2B2B"))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            } else if index == currentStep {
                                TextField("Type your answer...", text: $responses[index])
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .focused($isTextFieldFocused)
                                    .onSubmit {
                                        goToNextStep()
                                    }
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            if currentStep < questions.count {
                Button("Continue") {
                    goToNextStep()
                }
                .disabled(responses[currentStep].trimmingCharacters(in: .whitespaces).isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#58A7B5"))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isTextFieldFocused = true
            }
        }
    }
    
    
    private func goToNextStep() {
        if currentStep < questions.count - 1 {
            currentStep += 1
            isTextFieldFocused = true
        } else {
            print("📝 Final responses: \(responses)")

            Task {
                do {
                    if isFromMealScreen {
                        try await viewModel.submitDailyPreferences(
                            userId: "67faad3938b4003fd099adc0",
                            stressLevel: "Better",
                            sleepQuality: "Good",
                            sleepHours: 7,
                            injuries: "no",
                            notes: responses[0] // only note
                        )

                        if let mealVM = mealViewModel {
                            await mealVM.getModifiedMealPlan(forDay: viewModel.selectedDateIndex + 1, userId: "67faad3938b4003fd099adc0")
                        }

                    } else {
                        try await viewModel.submitDailyPreferences(
                            userId: "67faad3938b4003fd099adc0",
                            stressLevel: "Low",
                            sleepQuality: responses[0],
                            sleepHours: 8,
                            injuries: responses[1],
                            notes: responses[2]
                        )

                        await viewModel.fetchAndUpdateModifiedWorkoutPlan(forUser: "67faad3938b4003fd099adc0")
                    }

                    isPresented = false
                } catch {
                    print("❌ Error: \(error.localizedDescription)")
                }
            }
        }
    }

}
