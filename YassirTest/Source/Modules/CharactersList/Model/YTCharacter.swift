//
//  YTCharacter.swift
//  YassirTest
//
//  Created by Saad on 13/09/2024.
//

/// User model containing data only to be displayed in list
///
import Foundation

struct YTCharacter: Codable {
    
    /// Id of the object
    ///
    let id: Int

    /// Display Name of the Character. A non nullable string
    ///
    let name: String
    
    /// Thumbnail image url of character. A non nullable string
    ///
    let image: String
    
    /// Species of character. A non nullable string
    ///
    let species: String
    
    /// Status of character, nested Character.Status enum
    ///
    let status: CharacterStatus
    
    
    /// Static func to return a mocked character for testing and debugging purposes
    ///
    static var mockCharacter: YTCharacter {
        return YTCharacter(id: 1, name: "Sample Character", image: "https://picsum.photos/100/100.jpg", species: "Sample species", status: .unknown)
    }
    
}

