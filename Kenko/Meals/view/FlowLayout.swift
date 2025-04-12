//
//  FlowLayout.swift
//  Re_Note
//
//  Created by apple on 09/04/25.
//
import SwiftUI

struct FlowLayout<Content: View>: View {
    let items: [String]
    let spacing: CGFloat
    let content: (String) -> Content

    init(items: [String], spacing: CGFloat = 8, @ViewBuilder content: @escaping (String) -> Content) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(items, id: \.self) { item in
                content(item)
                    .padding(.all, 4)
                    .alignmentGuide(.leading) { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = 0
                            height -= dimension.height + spacing
                        }
                        let result = width
                        if item == items.last {
                            width = 0
                        } else {
                            width -= dimension.width + spacing
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in height }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
