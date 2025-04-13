//
//  Meal.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import Foundation

struct MealPlanResponse: Codable {
    let message: String
    let daysAvailable: Int
    let plan: [MealDay]
}

struct MealDay: Codable, Identifiable {
    var id: String { day } // for SwiftUI use
    let day: String
    let meals: MealTypes
}

struct MealTypes: Codable {
    let lunch: Meal
    let dinner: Meal
}

struct Meal: Codable {
    let name: String
    let ingredients: [String]
    let calories: Int
    let preparationTime: Int
    let macros: Macros
    let cuisine: String
    let preparation: String
}

struct Macros: Codable {
    let protein: Int
    let carbs: Int
    let fats: Int
}


struct IdentifiableMealSelection: Identifiable {
    let id = UUID()
    let meal: MealEntity
    let type: String
}

struct ModifiedMealPlanResponse: Codable {
    let message: String
    let modifiedMealPlan: MealDay
}
