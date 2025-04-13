//
//  WorkoutPlanDataManager.swift
//  Kenko
//
//  Created by apple on 13/04/25.
//


import CoreData

class WorkoutPlanDataManager {
    static let shared = WorkoutPlanDataManager()

    func saveWorkoutPlan(_ plan: WorkoutPlanResponse) {
        let context = CoreDataManager.shared.context

        let workoutPlanEntity = WorkoutPlanEntity(context: context)
        // workoutPlanEntity.message = plan.message

        for (index, day) in plan.week.enumerated() {
            let workoutDayEntity = WorkoutDayEntity(context: context)
            workoutDayEntity.day = day.day
            workoutDayEntity.dayIndex = Int16(index)

            let muscleGroupString = day.muscleGroups.joined(separator: ", ")
            workoutDayEntity.muscleGroups = muscleGroupString
            workoutDayEntity.intensity = day.intensity
            workoutDayEntity.plan = workoutPlanEntity

            // 💡 Print the index + muscle groups here:
            print("📌 Index \(index) - \(muscleGroupString)")

            for workout in day.workouts {
                let workoutEntity = WorkoutEntity(context: context)
                workoutEntity.name = workout.name
                workoutEntity.equipment = workout.equipment
                workoutEntity.sets = Int16(workout.sets)
                workoutEntity.reps = Int32(workout.reps)
                workoutEntity.duration = Int16(workout.duration)
                workoutEntity.youtube = workout.youtube
                workoutEntity.day = workoutDayEntity
                
            }
        }

        do {
            try context.save()
            print("✅ Workout plan saved to Core Data")
        } catch {
            print("❌ Failed to save workout plan: \(error)")
        }
    }
}
