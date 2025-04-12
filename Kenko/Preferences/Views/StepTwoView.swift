import SwiftUI

struct StepTwoView: View {
    let onContinue: () -> Void
    @FocusState private var isDurationFocused: Bool
    @ObservedObject var viewModel: PreferencesViewModel
    
    
    let goals = [
        ("Lose fat", "fatLoss", "fatLoss1"),
        ("Build muscle", "MuscleBuild", "MuscleBuild1"),
        ("Body recomposition", "recomp", "recomp1"),
        ("Improve strength", "strength", "strength1")
    ]


    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
          
            VStack(alignment: .leading, spacing: 4) {
                Text("Define Your ")
                    .foregroundColor(.white)
                    .font(.title3) +
                Text("Fitness Goals")
                    .foregroundColor(Color(hex: "#58A7B5"))
                    .font(.title3)
                    .bold()

                Text("Set your goal, choose your pace, and begin.")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#EFEFEF"))
            }
            .padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(goals, id: \.0) { goal, icon, icon1 in
                        GoalSelectionCard(
                            title: goal, subTitle: nil,
                            icon: icon,
                            icon1: icon1,
                            isSelected: viewModel.selectedGoal == goal,
                            onTap: { viewModel.selectedGoal = goal }
                        )
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Goal timeline")
                            .font(.headline)
                            .foregroundColor(.white)
                            .bold()

                        HStack(spacing: 8) {
                            TextField("", text: $viewModel.duration)
                                .keyboardType(.numberPad)
                                .focused($isDurationFocused)
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
                                            isDurationFocused = false
                                        }
                                    }
                                }

                            Text("Weeks")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        
                        HStack(spacing: 6) {
                            
                            Button(action:{
                                
                            }){
                                Image(systemName: "info.circle")
                                    .foregroundColor(Color(hex: "#919191"))
                                    .font(.footnote)
                            }
                            
                            Text("Optimal timeline set. Adjust if needed.")
                                .foregroundColor(Color(hex: "#919191"))
                                .font(.footnote)
                        }
                    }
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            

            if !isDurationFocused {
                Button(action: onContinue) {
                    Text("Continue")
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
