//
//  YTExtensions.swift
//  YassirTest
//
//  Created by Saad on 13/09/2024.
//

import Foundation
import SwiftUI

// MARK: - Creating a font extension so that we can use same font across app

/// Font
extension Font {
    public enum YTFont {
        case regular
        case bold
        case italic
        
        var value: String {
            switch self {
                case .regular:
                    return YTConstants.kNotoSansRegular
                case .bold:
                    return YTConstants.kNotoSansBold
                case .italic:
                    return YTConstants.kNotoSansItalic
            }
        }
    }
    
    public static func ytFont(_ type: YTFont, size: CGFloat = 16) -> Font {
        return .custom(type.value, size: size)
    }
}

extension Color {
    static var ytBlue: Color {
        return Color(red: 235/256.0, green: 241/256.0, blue: 256/256.0)
    }
    static var ytPink: Color {
        return Color(red: 251/256.0, green: 231/256.0, blue: 235/256.0)
    }
    static var ytLightGray: Color {
        return Color(red: 235/256.0, green: 241/256.0, blue: 256/256.0)
    }

    static var ytIndigo: Color {
        return Color(red: 80/256.0, green: 73/256.0, blue: 116/256.0)
    }
    
    static var ytLightIndigo: Color {
        return Color(red: 130/256.0, green: 124/256.0, blue: 156/256.0)
    }
    static var ytDarkIndigo: Color {
        return Color(red: 23/256.0, green: 3/256.0, blue: 65/256.0)
    }

}
