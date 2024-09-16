//
//  YTCharacterDetailAPIService.swift
//  YassirTest
//
//  Created by Saad on 15/09/2024.
//

import Foundation
import Combine


protocol YTCharacterDetailAPIService {
    /// Retrieves characters for page x with size n
    func getCharacterDetails(id: Int) -> AnyPublisher<YTCharacterDetails?, Error>
}

extension YTAPIGateway: YTCharacterDetailAPIService {
    /// Retrieves character details
    ///
    ///  - returns: A publisher with characters detail or an error
    ///
    func getCharacterDetails(id: Int) -> AnyPublisher<YTCharacterDetails?, any Error> {
        
        let url = "https://rickandmortyapi.com/api/character/\(id)"
        return get(url: url)
            .eraseToAnyPublisher()
        
    }
}
