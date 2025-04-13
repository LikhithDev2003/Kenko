//
//  PlanDetailScreen.swift
//  Re_Note
//
//  Created by apple on 08/04/25.
//


import SwiftUI
import CoreData

struct PlanDetailScreen: View {
    
    @Environment(\.dismiss) private var dismiss

    let plan: WorkoutDayEntity

    var totalDuration: Int {
        guard let workouts = plan.workouts as? Set<WorkoutEntity> else { return 0 }
        return workouts.reduce(0) { $0 + Int($1.duration) }
    }

    var sortedWorkouts: [WorkoutEntity] {
        (plan.workouts as? Set<WorkoutEntity>)?.sorted(by: { $0.name! < $1.name! }) ?? []
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Top title row with back button
            HStack {
                Button(action: {
                   AppState.shared.isTabBarVisible = true
                   dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }

                Text("Your Plan for \(plan.day ?? "-")")
                    .font(.title).bold()
                    .foregroundColor(.white)
                
                Spacer()
            }

            // Info pills row
            HStack(spacing: 12) {
                InfoPill(imageName: "duration", text: "\(totalDuration) mins")
                InfoPill(imageName: "level", text: plan.intensity?.capitalized ?? "-")
            }
            
            ScrollView {
                ForEach(Array(sortedWorkouts.enumerated()), id: \.offset) { index, exercise in
                    ExerciseCardView(exercise: exercise, index: index)
                }
            }
            .padding(.top)


        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}

struct InfoPill: View {
    let imageName: String
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Image(imageName)
                .resizable()
                .frame(width: 16, height: 16)
            Text(text)
                .font(.caption)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.white.opacity(0.1))
        .clipShape(Capsule())
    }
}
