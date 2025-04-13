//
//  NutrientItem.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import SwiftUI

struct NutrientItem: View {
    let label: String
    let value: Int

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("\(value)")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold() +
                Text("gms")
                    .foregroundColor(.white)
                    .font(.callout)
                    .bold()

            }
            Text(label)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
    }
}

