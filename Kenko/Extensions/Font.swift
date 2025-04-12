//
//  Font.swift
//  APIDemo
//
//  Created by apple on 02/04/25.
//


import SwiftUI

extension Font {
    static func euclid(_ style: Font.TextStyle = .body, weight: Font.Weight = .regular) -> Font {
        let fontName: String

        switch weight {
        case .bold:
            fontName = "Euclid Circular A Bold"
        case .semibold:
            fontName = "Euclid Circular A SemiBold"
        case .medium:
            fontName = "Euclid Circular A Medium"
        case .light:
            fontName = "Euclid Circular A Light"
        default:
            fontName = "Euclid Circular A Regular"
        }

        return .custom(fontName, size: UIFont.preferredFont(forTextStyle: UIFont.TextStyle(style)).pointSize)
    }
}

// Optional helper for UIFont.TextStyle conversion
extension UIFont.TextStyle {
    init(_ style: Font.TextStyle) {
        switch style {
        case .largeTitle: self = .largeTitle
        case .title: self = .title1
        case .title2: self = .title2
        case .title3: self = .title3
        case .headline: self = .headline
        case .subheadline: self = .subheadline
        case .callout: self = .callout
        case .caption: self = .caption1
        case .caption2: self = .caption2
        case .footnote: self = .footnote
        default: self = .body
        }
    }
}
