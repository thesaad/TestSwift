//
//  YTCharacterDetails.swift
//  YassirTest
//
//  Created by Saad on 16/09/2024.
//

import Foundation


struct YTCharacterDetails: Codable {
    
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
    
    /// Status of character
    ///
    let status: CharacterStatus
    
    /// Gender of character,
    ///
    let gender: String
    
    /// Origin of character,
    ///
    let origin: Origin?
    
    /// Location of character,
    ///
    let location: Location?
    
    /// Static func to return a mocked character for testing and debugging purposes
    ///
    static var mockCharacter: YTCharacterDetails {
        return YTCharacterDetails(id: 1, name: "Sample Character", image: "https://picsum.photos/100/100.jpg", species: "Sample species", status: .unknown, gender: "Male", origin: Origin(name: "XYZ", url: "XYZ"), location: Location(name: "Amsterdam", url: "XYZ"))
    }

    // MARK: nested structs for sub objects
    
    struct Location: Codable {
        /// Display Name of the Character location
        ///
        let name: String
        
        /// URL of the Character location
        ///
        let url: String?
    }
    
    struct Origin: Codable {
        /// Display Name of the Character Origin
        ///
        let name: String
        
        /// URL of the Character Origin
        ///
        let url: String?
    }
    

}
