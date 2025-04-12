//
//  MealDayCard.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import SwiftUI

struct MealDayCard: View {
    let mealDay: MealDay
    let isExpanded: Bool
    let onExpandToggle: () -> Void
    
    var totalCalories: Int {
        mealDay.meals.lunch.calories + mealDay.meals.dinner.calories
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(mealDay.day)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
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
                    .cornerRadius(20)

                Spacer()

                HStack(spacing: 4) {
                    Image("calCount")
                        .resizable()
                        .frame(width: 14, height: 16)
                    if isExpanded {
                        Text("Total calories")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                    Text("\(totalCalories)")
                        .foregroundColor(.white)
                        .font(.callout)
                        .bold()
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today’s meals, made for you")
                        .foregroundColor(.white)
                        .font(.body)
                    Text("Date")
                        .foregroundColor(.gray)
                        .font(.caption)
                }

                Spacer()

                Button(action: onExpandToggle) {
                    Image(systemName: isExpanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                        .foregroundColor(.white)
                }
            }

            if isExpanded {
                ForEach(mealDay.allMeals) { item in
                    MealCardView(mealType: item.type, meal: item.meal)
                }
            }
        }
        .padding()
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(hex: "#1E1E1E"))
        )
    }
}
