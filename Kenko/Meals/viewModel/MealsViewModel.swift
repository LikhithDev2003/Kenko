//
//  MealsViewModel.swift
//  Re_Note
//
//  Created by apple on 10/04/25.
//

import Foundation
import SwiftUI
import CoreData

class MealViewModel: ObservableObject {
    @Published var mealDays: [MealDayEntity] = []
    @Published var expandedDayID: String?

    init() {
        fetchMealDays()
    }

    func fetchMealDays() {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<MealDayEntity> = MealDayEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dayIndex", ascending: true)]

        do {
            self.mealDays = try context.fetch(request)
            print("✅ Fetched \(mealDays.count) meal days from Core Data")
        } catch {
            print("❌ Failed to fetch meal days: \(error)")
        }
    }

    func toggleExpansion(for dayID: String) {
        if expandedDayID == dayID {
            expandedDayID = nil
        } else {
            expandedDayID = dayID
        }
    }

    func isExpanded(dayID: String) -> Bool {
        return expandedDayID == dayID
    }
    
    
    func getModifiedMealPlan(forDay day: Int, userId: String) async {
        do {
            let response = try await NetworkManager.shared.getModifiedMealPlan(forDay: day, userId: userId)
            let modified = response.modifiedMealPlan

            let context = CoreDataManager.shared.context
            let request: NSFetchRequest<MealDayEntity> = MealDayEntity.fetchRequest()
            request.predicate = NSPredicate(format: "dayIndex == %d", day - 1)
            request.fetchLimit = 1

            if let existing = try context.fetch(request).first {
                // Delete old lunch and dinner if they exist
                if let lunch = existing.lunch {
                    context.delete(lunch)
                }
                if let dinner = existing.dinner {
                    context.delete(dinner)
                }

                // Create updated Lunch
                let lunchEntity = MealEntity(context: context)
                lunchEntity.name = modified.meals.lunch.name
                lunchEntity.ingredients = modified.meals.lunch.ingredients.joined(separator: ", ")
                lunchEntity.calories = Int16(modified.meals.lunch.calories)
                lunchEntity.preparationTime = Int16(modified.meals.lunch.preparationTime)
                lunchEntity.cuisine = modified.meals.lunch.cuisine
                lunchEntity.preparation = modified.meals.lunch.preparation

                let lunchMacros = MacroEntity(context: context)
                lunchMacros.protein = Int16(modified.meals.lunch.macros.protein)
                lunchMacros.carbs = Int16(modified.meals.lunch.macros.carbs)
                lunchMacros.fats = Int16(modified.meals.lunch.macros.fats)
                lunchEntity.macros = lunchMacros

                // Create updated Dinner
                let dinnerEntity = MealEntity(context: context)
                dinnerEntity.name = modified.meals.dinner.name
                dinnerEntity.ingredients = modified.meals.dinner.ingredients.joined(separator: ", ")
                dinnerEntity.calories = Int16(modified.meals.dinner.calories)
                dinnerEntity.preparationTime = Int16(modified.meals.dinner.preparationTime)
                dinnerEntity.cuisine = modified.meals.dinner.cuisine
                dinnerEntity.preparation = modified.meals.dinner.preparation

                let dinnerMacros = MacroEntity(context: context)
                dinnerMacros.protein = Int16(modified.meals.dinner.macros.protein)
                dinnerMacros.carbs = Int16(modified.meals.dinner.macros.carbs)
                dinnerMacros.fats = Int16(modified.meals.dinner.macros.fats)
                dinnerEntity.macros = dinnerMacros

                // Assign back
                existing.lunch = lunchEntity
                existing.dinner = dinnerEntity
                existing.day = modified.day

                try context.save()
                print("✅ Modified meal plan for Day \(day) saved to Core Data")
            } else {
                print("⚠️ No MealDayEntity found for Day \(day)")
            }
        } catch {
            print("❌ Failed to update modified meal plan: \(error.localizedDescription)")
        }
    }

}



extension MealDayEntity {
    var allMeals: [(id: UUID, type: String, meal: MealEntity)] {
        var meals: [(UUID, String, MealEntity)] = []
        if let lunch = lunch {
            meals.append((UUID(), "Lunch", lunch))
        }
        if let dinner = dinner {
            meals.append((UUID(), "Dinner", dinner))
        }
        return meals
    }
}
