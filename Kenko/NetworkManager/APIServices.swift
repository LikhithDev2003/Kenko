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
    
    
    
    func generateWorkoutPlan(userId: String) async throws {
        guard let url = URL(string: "http://127.0.0.1:8000/generate-workout-plan") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")

        // No request body needed for this endpoint
        request.httpBody = Data()

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

        let decoded = try JSONDecoder().decode(WorkoutPlanResponse.self, from: data)
        self.cachedWorkoutPlan = decoded
        return decoded
    }
    
    
    func generateMealPlan(userId: String) async throws -> MealPlanResponse {
        guard let url = URL(string: "http://127.0.0.1:8000/generate-meal-plan") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(userId, forHTTPHeaderField: "userId")
        request.httpBody = Data() // empty body as per your curl

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(MealPlanResponse.self, from: data)
        return decoded
    }


}

