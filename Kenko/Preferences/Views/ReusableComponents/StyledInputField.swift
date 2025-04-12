//
//  StyledInputField.swift
//  APIDemo
//
//  Created by apple on 06/04/25.
//


import SwiftUI

struct StyledInputField: View {
    let placeholder: String
    @Binding var text: String
    let showExample: Bool
    let exampleText: String?

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(
                "",
                text: $text,
                prompt: Text(placeholder).foregroundColor(.white.opacity(0.3))
            )
                .padding()
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "#2B2B2B"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(isFocused ? Color(hex: "#58A7B5") : Color.clear, lineWidth: 1)
                        )
                )
                .focused($isFocused)
                .font(.body)

            if showExample, let exampleText = exampleText {
                Text(exampleText)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top ,4)
            }
        }
    }
}
