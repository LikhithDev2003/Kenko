import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    var cachedWorkoutPlan: WorkoutPlanResponse?

    
    
    
    func postBasicInfo(
        userId: String,
        age: Int,
        gender: String,
        height: Int,
        weight: Int,
        goalWeight: Int
    ) async throws {
        guard let url = URL(string: "http://127.0.0.1:8000/preferences/basic-info") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        let body: [String: Any] = [
            "age": age,
            "gender": gender,
            "height": height,
            "weight": weight,
            "goalWeight": goalWeight
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        if let responseString = String(data: data, encoding: .utf8) {
            print("📝 Raw Response:")
            print(responseString)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("✅ Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
    }
    
    

    
    
    func postFitnessGoal(
        userId: String,
        goal: String,
        goalTimeline: String,
        activityLevel: String,
        experience: String,
        workoutTime: String,
        equipment: [String],
        injuries: String,
        nutrition: String,
        dietRestrictions: [String],
        preferredCuisines: [String],
        budgetForDiet: String
    ) async throws {
        guard let url = URL(string: "http://127.0.0.1:8000/preferences/fitness-goal") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        let body: [String: Any] = [
            "goal": goal,
            "goalTimeline": goalTimeline,
            "activityLevel": activityLevel,
            "experience": experience,
            "workoutTime": workoutTime,
            "equipment": equipment,
            "injuries": injuries,
            "nutrition": nutrition,
            "dietRestrictions": dietRestrictions,
            "preferredCuisines": preferredCuisines,
            "budgetForDiet": budgetForDiet
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)
        
        
        if let responseString = String(data: data, encoding: .utf8) {
            print("📝 Raw Response:")
            print(responseString)
        }

      
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("✅ Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
    }
    
    
    
    
    
    
    func postDailyPreferences(
        userId: String,
        stressLevel: String,
        sleepQuality: String,
        sleepHours: Int,
        injuries: String,
        notes: String
    ) async throws {
        guard let url = URL(string: "http://127.0.0.1:8000/preferences/daily") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        let body: [String: Any] = [
            "stressLevel": stressLevel,
            "sleepQuality": sleepQuality,
            "sleepHours": sleepHours,
            "injuries": injuries,
            "notes": notes
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        if let responseString = String(data: data, encoding: .utf8) {
            print("📝 Raw Response:")
            print(responseString)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("✅ Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
    }

    
    
    
    
    func generateWorkoutPlan(userId: String) async throws {
        guard let url = URL(string: "http://127.0.0.1:8000/generate-workout-plan") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        request.httpBody = nil // safer than sending `Data()`

        let (data, response) = try await URLSession.shared.data(for: request)

        if let responseString = String(data: data, encoding: .utf8) {
            print("📝 Raw Response:")
            print(responseString)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("✅ Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
    }
    
    
    

    func generateMealPlan(userId: String) async throws {
        guard let url = URL(string: "http://127.0.0.1:8000/generate-meal-plan") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        request.httpBody = nil // safer than sending `Data()`

        let (data, response) = try await URLSession.shared.data(for: request)

        if let responseString = String(data: data, encoding: .utf8) {
            print("📝 Raw Response:")
            print(responseString)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("✅ Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

    }
    
    

    
    
    func getWorkoutPlan(userId: String) async throws -> WorkoutPlanResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/get-workout-plan/weeks") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("📦 Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        do {
            let decoded = try JSONDecoder().decode(WorkoutPlanResponse.self, from: data)
            print("✅ JSON decoded successfully")
            return decoded
        } catch {
            print("❌ JSON Decoding Error: \(error)")
            throw error
        }
    }
    
    
    
    
    
    func getMealPlan(userId: String) async throws -> MealPlanResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/get-meal-plan") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("📦 Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        do {
            let decoded = try JSONDecoder().decode(MealPlanResponse.self, from: data)
            print("✅ Meal plan decoded successfully")
            return decoded
        } catch {
            print("❌ JSON Decoding Error: \(error)")
            throw error
        }
    }
    
    
    
    
    
    
    func getModifiedWorkoutPlan(forDay day: Int, userId: String) async throws -> ModifiedWorkoutPlanResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/get-workout-plan/day") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("\(day)", forHTTPHeaderField: "day")
        request.setValue(userId, forHTTPHeaderField: "userId")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let responseString = String(data: data, encoding: .utf8) {
            print("📝 Raw Response:")
            print(responseString)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("✅ Status Code: \(httpResponse.statusCode)")

        guard 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(ModifiedWorkoutPlanResponse.self, from: data)
        return decoded
    }
    
    
    
    
    func getModifiedMealPlan(forDay day: Int, userId: String) async throws -> ModifiedMealPlanResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/get-meal-plan/day") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("\(day)", forHTTPHeaderField: "day")
        request.setValue(userId, forHTTPHeaderField: "userId")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let responseString = String(data: data, encoding: .utf8) {
            print("📝 Raw Meal Plan Response:\n\(responseString)")
        }

        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(ModifiedMealPlanResponse.self, from: data)
        return decoded
    }



}

