//
//  ProfileMetricView.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import SwiftUI

struct ProfileMetricView: View {
    let value: String
    let unit: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Text(unit)
                    .foregroundColor(.white)
                    .font(.footnote)
            }
            Text(label)
                .foregroundColor(.white.opacity(0.7))
                .font(.footnote)
        }
        .frame(maxWidth: .infinity)
    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCorner(radius: radius, corners: corners)
        )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
