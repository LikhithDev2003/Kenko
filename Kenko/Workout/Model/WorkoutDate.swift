//
//  WorkoutDate.swift
//  Re_Note
//
//  Created by apple on 07/04/25.
//


import Foundation

struct WorkoutDate: Identifiable {
    let id = UUID()
    let dayName: String
    let dayNumber: String
    let date: Date
}





struct WorkoutPlanResponse: Codable {
    let message: String
    let week: [WorkoutDay]
}

struct WorkoutDay: Codable {
    let day: String
    let intensity: String
    let muscleGroups: [String]
    let workouts: [Workout]
}

struct Workout: Codable {
    let name: String
    let equipment: String
    let sets: Int
    let reps: Int
    let duration: Int
    let youtube: String
}


struct ModifiedWorkoutPlanResponse: Codable {
    let message: String
    let modifiedPlan: WorkoutDay
}

