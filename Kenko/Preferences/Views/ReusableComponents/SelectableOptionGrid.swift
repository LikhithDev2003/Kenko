//
//  SelectableOptionGrid.swift
//  APIDemo
//
//  Created by apple on 06/04/25.
//


import SwiftUI

struct SelectableOptionGrid: View {
    let options: [String]
    @Binding var selectedOption: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                            .font(.callout)
                            .foregroundColor(selectedOption == option ? .black : .white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(selectedOption == option ? Color(hex: "#58A7B5") : Color(hex: "#2B2B2B"))
                                    .stroke(
                                        selectedOption == option ? Color(hex: "#58A7B5") : Color.white.opacity(0.5),
                                        lineWidth: 1
                                    )
                            )
                    }
                }
            }
        }
    }
}
