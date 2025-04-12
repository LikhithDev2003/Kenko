//
//  StepOneView 3.swift
//  APIDemo
//
//  Created by apple on 01/04/25.
//
import SwiftUI

struct StepThreeView: View {
    let onContinue: () -> Void
    let Activity = [
        ("Lightly active", "Light", "Occasional walks or light movement", "Light1"),
        ("Moderately active", "Moderate", "Regular exercise (3-4 days a week)", "Moderate1"),
        ("Very active", "Very", "Intense workouts or physically demanding job", "Very1"),
        ("Athlete", "Athlete", "High-performance training or sports", "Athlete1")
    ]
    @ObservedObject var viewModel: PreferencesViewModel


    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title & Subtitle
            VStack(alignment: .leading, spacing: 4) {
                Text("Share Your ")
                    .foregroundColor(.white)
                    .font(.title3) +
                Text("Fitness Journey")
                    .foregroundColor(Color(hex: "#58A7B5"))
                    .font(.title3)
                    .bold()

                Text("Share your daily activity and experience level.")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#EFEFEF"))
            }
            .padding(.vertical)
            
            ScrollView{
                VStack(alignment: .leading, spacing: 8) {
                    Text("Experience level")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom)
                    
                    SelectableOptionGrid(
                        options: ["Beginner", "Intermediate", "Advanced", "Expert"],
                        selectedOption: $viewModel.selectedExperienceLevel
                    )
                    
                }
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Activity level")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical)
                    
                    
                    ForEach(Activity, id: \.0) { activity, icon , subtitle, icon1 in
                        GoalSelectionCard(
                            title: activity, subTitle: subtitle,
                            icon: icon,
                            icon1: icon1,
                            isSelected: viewModel.selectedActivity == activity,
                            onTap: { viewModel.selectedActivity = activity }
                        )
                    }
                }
            }


            
            
//            Spacer()

            // Continue Button
            Button(action: onContinue) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#58A7B5"))
                    .cornerRadius(30)
            }
//            .padding(.top, 24)
        }
        .padding(.horizontal)
    }
}
