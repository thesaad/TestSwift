//
//  WebAPITests.swift
//  YassirTestTests
//
//  Created by Saad on 16/09/2024.
//

import Foundation
import XCTest
@testable import YassirTest

class WebServicesHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIManager() {
        let s: YTCharacterAPIService = YTAPIGateway()
        XCTAssertNotNil(s, "WebServicesHelper instance Instantiate came back nil")
    }
        
    func testDownloadCharacterList() {
        
        let semaphore: DispatchSemaphore = DispatchSemaphore.init(value: 0)
        
        let staticFileToDownload: String = "https://rickandmortyapi.com/api/character?page=1"
        let characterAPIService: YTCharacterAPIService = YTAPIGateway()
        
        characterAPIService.getCharacters(page: 1, size: 20, status: nil)
            .receiveAndCancel(receiveOutput: { response in
                XCTAssertTrue(response.results!.count > 0)
                semaphore.signal()
            })
        semaphore.wait()

    }
    func testDownloadCharacterDetails() {
        
        let semaphore: DispatchSemaphore = DispatchSemaphore.init(value: 0)
        
        let staticFileToDownload: String = "https://rickandmortyapi.com/api/character?page=1"
        let characterAPIService: YTCharacterDetailAPIService = YTAPIGateway()
        
        characterAPIService.getCharacterDetails(id: 1)
            .receiveAndCancel(receiveOutput: { response in
                XCTAssertTrue(response != nil)
                semaphore.signal()
            })
        semaphore.wait()

    }
    
}
