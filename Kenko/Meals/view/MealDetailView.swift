import SwiftUI

struct MealDetailView: View {
    let mealType: String
    let meal: MealEntity

    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray.opacity(0.4))
                .frame(width: 80, height: 5)
                .padding(.top, 8)

            VStack(alignment: .leading, spacing: 16) {
                
                
                
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(mealType)
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(meal.name ?? "-")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        HStack(spacing: 6) {
                            Image("duration")
                                .resizable()
                                .frame(width: 16, height: 16)
                            Text("\(meal.preparationTime) mins")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        //                        Spacer()
                        
                        
                    }
                }
                
                
                ScrollView {
                    // Tags
                    HStack {
                        Text(meal.cuisine ?? "-")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color(hex: "#2B2B2B"))
                            .cornerRadius(20)
                        
                        
                        Spacer()
                        
                        HStack (spacing: 4){
                            Image("calCount")
                                .resizable()
                                .frame(width: 18, height: 20)
                            Text("\(meal.calories) kcal")
                                .foregroundColor(.white)
                                .font(.callout)
                                .bold()
                        }
                    }
                    .padding(.top)
                    
                    // Nutrients
                    HStack {
                        NutrientItem(label: "Proteins", value: Int(meal.macros?.protein ?? 0))
                        Divider().frame(height: 48).background(Color.gray)
                        NutrientItem(label: "Carbs", value: Int(meal.macros?.carbs ?? 0))
                        Divider().frame(height: 48).background(Color.gray)
                        NutrientItem(label: "Fat", value: Int(meal.macros?.fats ?? 0))
                    }
                    .padding()
                    .background(Color(hex: "#2B2B2B"))
                    .cornerRadius(4)
                    
                    // Ingredients
                    
                    VStack(alignment: .leading) {
                        HStack {
                            HStack (spacing: 8){
                                Image("shop")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text("Ingredients")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .bold()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach((meal.ingredients?.components(separatedBy: ", ") ?? []), id: \.self) { ingredient in
                                Text(ingredient)
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.8))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color(hex: "#2B2B2B"))
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.top, 12)
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 32)
                    
                    
                    
                    VStack(alignment: .leading) {
                        HStack {
                            HStack (spacing: 8){
                                Image("prep")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text("Preperation")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .bold()
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 6) {
                                
                                Image("link") // Replace with "learn" icon if custom
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text("Learn")
                                    .font(.footnote)
                                    .underline()
                                    .bold()
                                    .foregroundColor(Color(hex: "#58A7B5"))
                            }
                            
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 8) {
                                Text("•")
                                    .foregroundColor(.white)
                                    .font(.callout)
                                    .bold()
                                
                                
                                Text(meal.preparation ?? "-")
                                    .foregroundColor(.white)
                                    .font(.callout)
                                    .padding(.top, 12)
                                
                            }
                            .padding(.leading, 8)
                        }
                        .padding(.top, 12)
                    }
                    .padding(.top, 32)
                }
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}


