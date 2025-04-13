//
//  MealDayCard.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import SwiftUI

struct MealDayCard: View {
    let mealDay: MealDayEntity
    let isExpanded: Bool
    let isSelected: Bool
    let onExpandToggle: () -> Void
    @State private var selectedMealItem: IdentifiableMealSelection?
    
    
    var totalCalories: Int {
        Int((mealDay.lunch?.calories ?? 0) + (mealDay.dinner?.calories ?? 0))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                
//                here meal day should be displayed like day 1 or day 2
                Text(mealDay.day ?? "-")
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
                    
//                    here sum of  calories of all the meal entities should be displayed.
                    
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
                ForEach(mealDay.allMeals, id: \.id) { item in
                    MealCardView(mealType: item.type, meal: item.meal)
                        .onTapGesture {
                            selectedMealItem = IdentifiableMealSelection(meal: item.meal, type: item.type)
                        }
                }
            }
        }
        .sheet(item: $selectedMealItem) { item in
            MealDetailView(mealType: item.type, meal: item.meal)
                .presentationDetents([.fraction(0.8)])
            
        }

        .padding()
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(hex: "#1E1E1E"))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isSelected ? Color(hex: "#58A7B5") : Color.clear, lineWidth: 2)
                )

        )
    }
}
