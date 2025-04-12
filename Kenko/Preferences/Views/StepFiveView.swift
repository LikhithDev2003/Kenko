import SwiftUI

struct StepFiveView: View {
    let onContinue: () -> Void
    @StateObject private var keyboard = KeyboardResponder()
    @FocusState private var isBudgetFocused: Bool
    @ObservedObject var viewModel: PreferencesViewModel
    @Binding var hasCompletedOnboarding: Bool
    

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title & Subtitle
            VStack(alignment: .leading, spacing: 4) {
                Text("Final step personalize your ")
                    .foregroundColor(.white)
                    .font(.title3) +
                Text("Routine")
                    .foregroundColor(Color(hex: "#58A7B5"))
                    .font(.title3)
                    .bold()
                
                Text("Customize your meal and workout preferences")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#EFEFEF"))
            }
            .padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Workouts:")
                        .font(.title3)
                        .foregroundColor(Color(hex: "#58A7B5"))
                        .bold()
                        .padding(.bottom)
                    
                    Text("Workout Time Preference")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom)
                    
                    SelectableOptionGrid(
                        options: ["Morning", "Evening"],
                        selectedOption: $viewModel.timePreference
                    )
                    
                }
                .padding(.bottom)
                
                
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Meals:")
                        .font(.title3)
                        .foregroundColor(Color(hex: "#58A7B5"))
                        .bold()
                        .padding(.bottom)
                    
                    Text("Specify your cuisine preference")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom)
                    
                    StyledInputField(
                        placeholder: "Enter your cuisine preference",
                        text: $viewModel.cusine,
                        showExample: true,
                        exampleText: "(Indian, Italian, Mexican)"
                    )
                    
                    HStack(spacing: 6) {
                        
                        Button(action:{
                            
                        }){
                            Image(systemName: "info.circle")
                                .foregroundColor(Color(hex: "#919191"))
                                .font(.footnote)
                        }
                        
                        Text("Helps in customizing your meal plan")
                            .foregroundColor(Color(hex: "#919191"))
                            .font(.footnote)
                    }
                }
                .padding(.bottom)
                
                HStack(spacing: 4) {
                    
                    Text("Weekly Meal Budget:")
                        .foregroundColor(.white)
                        .font(.headline)
                        .bold()
                        .padding(.trailing, 12)
                    
                    TextField("", text: $viewModel.budget)
                        .keyboardType(.numberPad)
                        .focused($isBudgetFocused)
                        .multilineTextAlignment(.center)
                        .frame(width: 62, height: 48)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: "#2B2B2B"))
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isBudgetFocused = false
                                }
                            }
                        }
                    
                    Text("Rupees")
                        .foregroundColor(.white)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            
            
            if !keyboard.isKeyboardVisible {
                Button(action: {
                    
                    onContinue()

                    Task.detached(priority: .background) {
                        do {
                            try await viewModel.POSTBasicInfo()
                            print("✅ Basic info submitted")

                            try await viewModel.POSTFitnessGoal()
                            print("✅ Fitness goal submitted")
                            
                            
                            DispatchQueue.main.async {
                                hasCompletedOnboarding = true
                            }

                        } catch {
                            print("❌ Error during background submission: \(error.localizedDescription)")
                        }
                    }
                    
                }) {
                    Text("Finish")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#58A7B5"))
                        .cornerRadius(30)
                }
            }
        }
        .padding(.horizontal)
    }
}
