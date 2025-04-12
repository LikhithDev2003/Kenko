import SwiftUI

struct WorkoutCardView: View {
    
    let plan: WorkoutDay
    let isSelected: Bool
    
    var totalDuration: Int {
        plan.workouts.reduce(0) { $0 + $1.duration }
    }
    let onViewDetail: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(plan.day)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(hex: "#124F5C"),
                                            Color(hex: "#326672")
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                    
                    Spacer()
                    
                }
                .padding(.bottom)
                
                Text(plan.muscleGroups.joined(separator: ", "))
                    .font(.headline)
                    .foregroundColor(.white)
                
                
                HStack(spacing: 20) {
                    WorkoutInfoItem(imageName: "duration", text: "\(totalDuration) mins")
                    WorkoutInfoItem(imageName: "level", text: plan.intensity.capitalized)
                }

                .padding(.bottom)
                

                    Button(action: {
                        onViewDetail()
                    }) {
                        Text("View workout plan")
                            .font(.subheadline.bold())
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(hex: "#58A7B5"))
                            .cornerRadius(30)
                    }
            }
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "#1E1E1E"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isSelected ? Color(hex: "#58A7B5") : Color.clear, lineWidth: 2)
                        )
                }
            )
        }
    }
}






struct WorkoutInfoItem: View {
    let imageName: String
    let text: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(imageName)
                .resizable()
                .frame(width: 16, height: 16)
            Text(text)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}
