//
//  YTCharacterListUITests.swift
//  YassirTestUITests
//
//  Created by Saad on 16/09/2024.
//

import XCTest
@testable import YassirTest

class YTCharacterListUITestsclass: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func tableViewDidLoadCell() {
        
        
        let viewController = YTCharactersViewController()
        viewController.viewModel.list = MockCharactersFetcher.mockList()
        
        // then
        XCTAssertNotNil(viewController.tableView)
    }
    
}
