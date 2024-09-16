//
//  YTGetCharactersResponse.swift
//  YassirTest
//
//  Created by Saad on 16/09/2024.
//

import Foundation

struct YTGetCharactersResponse: Codable {
    let results: [YTCharacter]?
    let info: Info
    struct Info: Codable {
        let pages: Int
    }
}
