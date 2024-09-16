//
//  BaseXCUIElement.swift
//  YassirTestUITests
//
//  Created by Saad on 16/09/2024.
//

import XCTest

internal class BaseXCUIElement {
    
    internal static let app: XCUIApplication = XCUIApplication()
    private static let defaultTimeout: Double = 30.0
    
    internal static func waitForExistance(ofElement element: XCUIElement, forTimeout timeout: Double = defaultTimeout) -> XCUIElement {
        let _ = element.waitForExistence(timeout: timeout)
        return element
    }
}
