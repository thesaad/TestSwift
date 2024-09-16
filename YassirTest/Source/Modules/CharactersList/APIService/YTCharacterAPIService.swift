//
//  YTCharacterAPIService.swift
//  YassirTest
//
//  Created by Saad on 15/09/2024.
//

import Foundation
import Combine


protocol YTCharacterAPIService {
    /// Retrieves characters for page x with size n
    func getCharacters(page: Int, size: Int, status: CharacterStatus?) -> AnyPublisher<YTGetCharactersResponse, Error>
}

extension YTAPIGateway: YTCharacterAPIService {
    /// Retrieves characters for page x with size n
    ///
    ///  - returns: A publisher with characters list or an error
    ///
    func getCharacters(page: Int, size: Int, status: CharacterStatus? = nil) -> AnyPublisher<YTGetCharactersResponse, any Error> {
        
        var url = "https://rickandmortyapi.com/api/character?page=\(page)"
        if let status = status {
            url.append("&status=\(status)")
        }
        return get(url: url)
            .eraseToAnyPublisher()
        
    }
}
