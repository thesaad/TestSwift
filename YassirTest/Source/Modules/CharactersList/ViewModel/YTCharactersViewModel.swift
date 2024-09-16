//
//  YTCharactersViewModel.swift
//  YassirTest
//
//  Created by Saad on 13/09/2024.
//

import Foundation
import Combine
import ProgressHUD

// This is gonna interact with UIKit so no need to create subclass of ObservalbleObject
final class YTCharactersViewModel: NSObject {
    
    // MARK: - Variables
    // We just need success as data is being managed in ViewModel
    var datahandler: ((_ success: Bool, _ error: Error?) -> ())?
    var list: [YTCharacter] = Array() // We are going to add objects always in array
    var currentPage = 1
    var isLoadingData = false
    /// The api supports 20 pages for now. mentioning here just for refernce.
    let pageSize = 20
    
    //To check if there are more pages
    var hasMorePages = true
    // to filter data
    var filterStatus: CharacterStatus?

    // A protocol oriented approach to for fetching data. No singleton as Swift will take care of objects
    private var characterAPIService: YTCharacterAPIService
    
    // MARK: - Object Lifecycle
    
    override init() {
        self.characterAPIService = YTAPIGateway()
    }
    
    // MARK: - API Calls
    /// Reseting to first page
    func loadFirstPage() {
        currentPage = 1
        self.list = Array()
        loadCharacters()
    }
    
    /// Load next page
    ///
    func loadNext() {
        currentPage += 1
        loadCharacters()
    }
    
    /// Load data for current page
    ///
    func loadCharacters() {
        ProgressHUD.animate()
        isLoadingData = true
        characterAPIService.getCharacters(page: currentPage, size: pageSize, status: filterStatus)
            .receiveAndCancel(receiveOutput: { [weak self] response in
//                debugPrint("\(String(describing: response.results))")
                self?.list += response.results ?? []
                // Inform View to get updated
                self?.datahandler?(true, nil)
                ProgressHUD.dismiss()
                self?.isLoadingData = false
                self?.hasMorePages = self?.currentPage ?? 1 < response.info.pages

            }, receiveError: { [weak self] error in
                print("\(error)")
                self?.datahandler?(false , error)
                ProgressHUD.bannerHide()
                self?.isLoadingData = false
                
            })
    }
}
