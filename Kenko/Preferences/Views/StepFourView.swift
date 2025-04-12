//
//  StepOneView 4.swift
//  APIDemo
//
//  Created by apple on 01/04/25.
//
import SwiftUI

struct StepFourView: View {
    let onContinue: () -> Void
    @StateObject private var keyboard = KeyboardResponder()
    @ObservedObject var viewModel: PreferencesViewModel
    
    
    let Injuries = [
        ("Yes"),
        ("No")
    ]



    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title & Subtitle
            VStack(alignment: .leading, spacing: 4) {
                Text("Customize Your ")
                    .foregroundColor(.white)
                    .font(.title3) +
                Text("Health & Lifestyle")
                    .foregroundColor(Color(hex: "#58A7B5"))
                    .font(.title3)
                    .bold()

                Text("Tailor your plan to fit your body and needs.")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#EFEFEF"))
            }
            .padding(.vertical)

            
            
            
            
            ScrollView{
                VStack(alignment: .leading, spacing: 8) {
                    Text("Experience level")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom)
                    
                    SelectableOptionGrid(
                        options: ["Vegetarian", "Non vegetarian", "Vegan", "Custom"],
                        selectedOption: $viewModel.selectedNutrition
                    )
                    
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Specify if any dietary restriction")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical)
                    
                    
                    StyledInputField(
                        placeholder: "Enter your dietary restrictions",
                        text: $viewModel.dietaryText,
                        showExample: true,
                        exampleText: "(Lactose free, Gluten free)"
                    )
                }
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Do you have any existing injuries?")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .padding(.vertical)
                    
                    StyledInputField(
                        placeholder: "Describe your injury with severity",
                        text: $viewModel.injuries,
                        showExample: true,
                        exampleText: "(Shoulder Injury, Wrist Injury)"
                    )
                }
            }



            if !keyboard.isKeyboardVisible {
                Button(action: onContinue) {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#58A7B5"))
                        .cornerRadius(30)
                }
            }

        }
        .padding(.horizontal)
    }
}




