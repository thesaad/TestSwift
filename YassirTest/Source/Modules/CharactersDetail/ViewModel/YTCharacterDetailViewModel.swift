//
//  YTCharacterDetailView.swift
//  YassirTest
//
//  Created by Saad on 16/09/2024.
//

import Foundation

// This is because for SwiftUI, we will create ObservableObject subclass
final class YTCharacterDetailViewModel: ObservableObject {
    // MARK: Vars
    let id: Int
    
    // A protocol oriented approach to for fetching data. No singleton as Swift will take care of objects
    private var characterDetailsAPIService: YTCharacterDetailAPIService

    
    // MARK: Published vars
    @Published var character: YTCharacterDetails?
    @Published var isLoading = false
    
    // MARK: Object Lifecycle
    init(id: Int) {
        self.id = id
        self.characterDetailsAPIService = YTAPIGateway()
        loadDetails()
    }
    
    // MARK: Loading Data
    private func loadDetails() {
        isLoading = true
        self.characterDetailsAPIService.getCharacterDetails(id: id)
            .receive(on: DispatchQueue.main)
            .receiveAndCancel(receiveOutput: { [weak self] response in
                
                self?.character = response
                self?.isLoading = false
                
            }, receiveError: { [weak self] error in
                print("\(error)")
                self?.isLoading = false
            })
    }
}
