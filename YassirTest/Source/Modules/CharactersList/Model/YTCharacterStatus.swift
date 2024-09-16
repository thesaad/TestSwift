//
//  YTCharacterStatus.swift
//  YassirTest
//
//  Created by Saad on 16/09/2024.
//

import Foundation
import SwiftUI

enum CharacterStatus: String, Codable {
    
    case Alive, Dead, unknown
    
    /// Colors based on status
    var fillColor: Color {
        switch self {
        case .Alive:
            return .ytBlue
        case .Dead:
            return .ytPink
        case .unknown:
            return .clear
        }
    }
    
    var borderColor: Color {
        switch self {
        case .Alive:
            return .clear
        case .Dead:
            return .clear
        case .unknown:
            return .ytLightGray
        }
    }
    
}
