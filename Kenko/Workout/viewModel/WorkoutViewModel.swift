//
//  WorkoutViewModel.swift
//  Re_Note
//
//  Created by apple on 07/04/25.
//


import Foundation
import SwiftUI
import CoreData

class WorkoutViewModel: ObservableObject {
    @Published var weekDates: [WorkoutDate] = []
    @Published var selectedDateIndex: Int = 0
    @Published var workoutDays: [WorkoutDayEntity] = []
    
    
    private let calendar = Calendar.current
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "E"
        return df
    }()
    
    init() {
        generateWeekDates()
        fetchWorkoutDays() 
    }
    
    func generateWeekDates() {
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - calendar.firstWeekday), to: today)!

        var tempDates: [WorkoutDate] = []

        for i in 0..<21 {
            if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                let dayName = formatter.string(from: date)
                let dayNumber = String(calendar.component(.day, from: date))
                tempDates.append(WorkoutDate(dayName: dayName, dayNumber: dayNumber, date: date))
            }
        }

        weekDates = tempDates
        
        if let todayIndex = weekDates.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: today) }) {
            selectedDateIndex = todayIndex
        }
    }
    
    
    func selectDate(at index: Int) {
        selectedDateIndex = index
    }
    
    
    func fetchWorkoutDays() {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<WorkoutDayEntity> = WorkoutDayEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dayIndex", ascending: true)]

        do {
            self.workoutDays = try context.fetch(request)
            print("Fetched \(workoutDays.count) workout days from Core Data")
        } catch {
            print("Failed to fetch: \(error)")
        }
    }
    
    
    func submitDailyPreferences(
        userId: String,
        stressLevel: String,
        sleepQuality: String,
        sleepHours: Int,
        injuries: String,
        notes: String
    ) async throws {
        try await NetworkManager.shared.postDailyPreferences(
            userId: userId,
            stressLevel: stressLevel,
            sleepQuality: sleepQuality,
            sleepHours: sleepHours,
            injuries: injuries,
            notes: notes
        )
    }
    
    
    
    
    func fetchAndUpdateModifiedWorkoutPlan(forUser userId: String) async {
        do {
            let day = selectedDateIndex + 1 // Days in the API are 1-indexed
            let modifiedResponse = try await NetworkManager.shared.getModifiedWorkoutPlan(forDay: day, userId: userId)

            let modifiedDay = modifiedResponse.modifiedPlan

            let context = CoreDataManager.shared.context
            let request: NSFetchRequest<WorkoutDayEntity> = WorkoutDayEntity.fetchRequest()
            request.predicate = NSPredicate(format: "dayIndex == %d", selectedDateIndex)
            request.fetchLimit = 1

            if let existingEntity = try context.fetch(request).first {
                // Delete existing workouts
                if let existingWorkouts = existingEntity.workouts as? Set<WorkoutEntity> {
                    for workout in existingWorkouts {
                        context.delete(workout)
                    }
                }

                // Update day fields
                existingEntity.day = modifiedDay.day
                existingEntity.intensity = modifiedDay.intensity
                existingEntity.muscleGroups = modifiedDay.muscleGroups.joined(separator: ", ")

                // Add new workouts
                for workout in modifiedDay.workouts {
                    let workoutEntity = WorkoutEntity(context: context)
                    workoutEntity.name = workout.name
                    workoutEntity.equipment = workout.equipment
                    workoutEntity.sets = Int16(workout.sets)
                    workoutEntity.reps = Int32(workout.reps)
                    workoutEntity.duration = Int16(workout.duration)
                    workoutEntity.youtube = workout.youtube
                    workoutEntity.day = existingEntity
                }

                try context.save()
                print("✅ Core Data updated for day \(day)")
            } else {
                print("⚠️ WorkoutDayEntity not found for index \(selectedDateIndex)")
            }

        } catch {
            print("❌ Error updating modified workout plan: \(error.localizedDescription)")
        }
    }

    
    



}
