//
//  Meal.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import Foundation

//struct Meal: Identifiable {
//    let id = UUID()
//    let type: String
//    let name: String
//    let time: String
//    let calories: String
//    let imageName: String
//}
//
//struct MealDay: Identifiable {
//    let id = UUID()
//    let dayLabel: String
//    let dateString: String
//    let totalCalories: String
//    let meals: [Meal]
//}



struct MealPlanResponse: Codable {
    let message: String
    let plan: [MealDay]
}

struct MealDay: Codable, Identifiable {
    var id: String { day } // for SwiftUI use
    let day: String
    let meals: MealTypes
    var allMeals: [MealWithType] {
        [
            MealWithType(type: "Lunch", meal: meals.lunch),
            MealWithType(type: "Dinner", meal: meals.dinner)
        ]
    } 
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

struct MealWithType: Identifiable {
    let id = UUID()
    let type: String // "Lunch" or "Dinner"
    let meal: Meal
}

