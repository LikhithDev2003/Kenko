//
//  ExerciseCardView.swift
//  Re_Note
//
//  Created by apple on 08/04/25.
//
import SwiftUI

struct ExerciseCardView: View {
    let exercise: WorkoutEntity
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Workout \(index + 1)")
                            .font(.caption)
                            .foregroundColor(Color(hex: "#919191"))
                        
                    }
                    
                    Spacer()
                    HStack(spacing: 6) {
                        
                        Image("link") // Replace with "learn" icon if custom
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text("Learn")
                            .font(.footnote)
                            .underline()
                            .bold()
                            .foregroundColor(Color(hex: "#58A7B5"))
                    }
                    .onTapGesture {
                        if let url = URL(string: exercise.youtube ?? "") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
                
                HStack {
                    
                    Text(exercise.name ?? "-")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(exercise.duration) mins | \(exercise.equipment ?? "-")")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color(hex: "#919191"))
                }
            }
            .padding(.bottom, 12)
            
            
            ZStack(alignment: .bottomLeading) {
                Image("WorkoutImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
//                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(8)
                
                // Gradient + Sets & Reps overlay
                LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color.black.opacity(1.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .cornerRadius(8)
                //                .frame(height: 80) // Optional: control height of fade
                .padding(.top, 76) // push it to bottom
                
                VStack(spacing: 12) {
                    
                    HStack(spacing: 12) {
                        Text("Sets")
                            .foregroundColor(.white)
                        Text("\(exercise.sets)")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(hex: "#58A7B5"))
                            .cornerRadius(4)
                            .foregroundColor(.black)
                            .bold()
                        
                        Text("Reps")
                            .foregroundColor(.white)
                        Text("\(exercise.reps)")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(hex: "#58A7B5"))
                            .cornerRadius(4)
                            .foregroundColor(.black)
                            .bold()
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Button
                    Button(action: {}) {
                        Text("Start workout")
                            .font(.subheadline.bold())
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(hex: "#58A7B5"))
                            .cornerRadius(30)

                    }

                }
                
                
            }
            
        }
        .padding(.bottom, 24)

    }
}
