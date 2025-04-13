//
//  MealCardView.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//


import SwiftUI

struct MealCardView: View {
    let mealType: String
    let meal: MealEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(spacing: 8) {
                Image("Lunch")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    
//                    Lunch or dinner
                    Text(mealType.capitalized)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
//                    name of the meal
                    
                    Text(meal.name ?? "-")
                        .foregroundColor(.white)
                }
            }
            
            HStack(spacing: 8) {
                
                Spacer()
                HStack(spacing: 2) {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)


//                    preperation time for the meal
                    
                    Text("\(meal.preparationTime) mins")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                HStack (spacing: 2){
                    Image("calCount")
                        .resizable()
                        .frame(width: 14, height: 16)
                    
//                    calories for that particular meal
                    
                    Text("\(meal.calories) kcal")
                        .foregroundColor(.white)
                        .font(.caption)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.trailing)
        .padding(.leading, 8)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.black)
        )

        .cornerRadius(4)
    }
}
