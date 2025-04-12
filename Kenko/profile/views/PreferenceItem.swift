//
//  PreferenceItem.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import SwiftUI

struct PreferenceItem: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.white.opacity(0.7))
                .font(.footnote)
            Spacer()
            Text(value)
                .foregroundColor(.white)
                .font(.callout)
                
        }
        .padding()
        .background(.black)
        .cornerRadius(4)
    }
}
