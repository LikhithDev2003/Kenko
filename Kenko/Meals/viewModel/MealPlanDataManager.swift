//
//  MealPlanDataManager.swift
//  Kenko
//
//  Created by apple on 13/04/25.
//


import CoreData

class MealPlanDataManager {
    static let shared = MealPlanDataManager()

    func saveMealPlan(_ response: MealPlanResponse) {
        let context = CoreDataManager.shared.context

        let mealPlanEntity = MealPlanEntity(context: context)
        mealPlanEntity.daysAvailable = Int16(response.daysAvailable)

        for (index, day) in response.plan.enumerated() {
            let mealDayEntity = MealDayEntity(context: context)
            mealDayEntity.day = day.day
            mealDayEntity.dayIndex = Int16(index)
            mealDayEntity.plan = mealPlanEntity

            // Lunch
            let lunchEntity = MealEntity(context: context)
            lunchEntity.name = day.meals.lunch.name
            lunchEntity.ingredients = day.meals.lunch.ingredients.joined(separator: ", ")
            lunchEntity.calories = Int16(day.meals.lunch.calories)
            lunchEntity.preparationTime = Int16(day.meals.lunch.preparationTime)
            lunchEntity.cuisine = day.meals.lunch.cuisine
            lunchEntity.preparation = day.meals.lunch.preparation

            let lunchMacros = MacroEntity(context: context)
            lunchMacros.protein = Int16(day.meals.lunch.macros.protein)
            lunchMacros.carbs = Int16(day.meals.lunch.macros.carbs)
            lunchMacros.fats = Int16(day.meals.lunch.macros.fats)
            lunchEntity.macros = lunchMacros

            // Dinner
            let dinnerEntity = MealEntity(context: context)
            dinnerEntity.name = day.meals.dinner.name
            dinnerEntity.ingredients = day.meals.dinner.ingredients.joined(separator: ", ")
            dinnerEntity.calories = Int16(day.meals.dinner.calories)
            dinnerEntity.preparationTime = Int16(day.meals.dinner.preparationTime)
            dinnerEntity.cuisine = day.meals.dinner.cuisine
            dinnerEntity.preparation = day.meals.dinner.preparation

            let dinnerMacros = MacroEntity(context: context)
            dinnerMacros.protein = Int16(day.meals.dinner.macros.protein)
            dinnerMacros.carbs = Int16(day.meals.dinner.macros.carbs)
            dinnerMacros.fats = Int16(day.meals.dinner.macros.fats)
            dinnerEntity.macros = dinnerMacros

            mealDayEntity.lunch = lunchEntity
            mealDayEntity.dinner = dinnerEntity

            print("📌 Saved Day \(index + 1): \(day.day) with Lunch: \(lunchEntity.name ?? "-") and Dinner: \(dinnerEntity.name ?? "-")")
        }

        do {
            try context.save()
            print("✅ Meal plan saved to Core Data")
        } catch {
            print("❌ Failed to save meal plan: \(error)")
        }
    }
}
