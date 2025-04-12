//
//  DropDownField.swift
//  APIDemo
//
//  Created by apple on 01/04/25.
//
import SwiftUI

struct DropDownField: View {
    var label: String
    var value: String
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .foregroundColor(isSelected ? Color(hex: "#58A7B5") : Color(hex: "#5F5F5F"))
                .font(.caption)

            HStack {
                Text(value)
                    .foregroundColor(Color(hex: "#EFEFEF"))
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(Color(hex: "#EFEFEF"))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: "#2B2B2B"))
                    .stroke(isSelected ? Color(hex: "#58A7B5") : Color.clear , lineWidth: 1)
            )
            .onTapGesture {
                onTap()
            }
        }
        .padding(.vertical, 4)
    }
}
