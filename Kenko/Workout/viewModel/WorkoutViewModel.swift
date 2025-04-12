//
//  WorkoutViewModel.swift
//  Re_Note
//
//  Created by apple on 07/04/25.
//


import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var weekDates: [WorkoutDate] = []
    @Published var selectedDateIndex: Int = 0
    @Published var workoutWeek: [WorkoutDay] = []
    
    
    var currentDayPlan: WorkoutDay? {
        guard workoutWeek.indices.contains(selectedDateIndex) else { return nil }
        return workoutWeek[selectedDateIndex]
    }

    
    
    private let calendar = Calendar.current
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "E"
        return df
    }()
    
    init() {
        generateWeekDates()
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
}
