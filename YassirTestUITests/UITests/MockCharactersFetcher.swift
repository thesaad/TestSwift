//
//  MockCharactersFetcher.swift
//  YassirTestUITests
//
//  Created by Saad on 16/09/2024.
//

import Foundation
@testable import YassirTest

class MockCharactersFetcher {
    static func mockList() -> [YTCharacter] {
        var result = [YTCharacter]()
        
        for i in 1...20 {
            let character = YTCharacter(id: i, name: "Character \(i)", image: "", species: "Specie \(i)", status: .Alive)
            result.append(character)
        }
        return result
    }
}
