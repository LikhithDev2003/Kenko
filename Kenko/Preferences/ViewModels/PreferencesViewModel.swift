import Foundation
import SwiftUI

class PreferencesViewModel: ObservableObject {
    @Published var gender: String = ""
    @Published var dob: Date = Date()
    @Published var weight: Int = 60
    @Published var height: Int = 170
    @Published var goalWeight: Int = 65
    @Published var selectedGoal: String?
    @Published var duration: String = "2"
    @Published var selectedActivity: String?
    @Published var selectedExperienceLevel: String? = nil
    @Published var selectedNutrition: String? = nil
    @Published var dietaryText: String = ""
    @Published var injuries: String = ""
    @Published var budget: String = "1000"
    @Published var timePreference: String? = nil
    @Published var cusine: String = ""

    // hardcoded userId for now (replace with your logic)
    private let userId = "67fa3a3d38b4003fd099adb2"

    func calculateAge(from date: Date) -> Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
        return ageComponents.year ?? 0
    }

    func POSTBasicInfo() async throws {
        let age = calculateAge(from: dob)

        try await NetworkManager.shared.postBasicInfo(
            userId: userId,
            age: age,
            gender: gender.lowercased(),
            height: height,
            weight: weight,
            goalWeight: goalWeight
        )
    }
    
    
    func POSTFitnessGoal() async throws {
        try await NetworkManager.shared.postFitnessGoal(
            userId: userId,
            goal: selectedGoal ?? "",
            goalTimeline: duration,
            activityLevel: selectedActivity ?? "",
            experience: selectedExperienceLevel ?? "",
            workoutTime: timePreference ?? "",
            equipment: ["Dumbells"], // Modify if you collect this dynamically
            injuries: injuries,
            nutrition: selectedNutrition ?? "",
            dietRestrictions: dietaryText.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            preferredCuisines: cusine.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            budgetForDiet: budget
        )
    }
}
