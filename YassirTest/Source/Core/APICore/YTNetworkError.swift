//
//  YTNetworkError.swift
//  YassirTest
//
//  Created by Saad on 15/09/2024.
//

import Foundation

enum YTNetworkError: Error {  // (2)
    case invalidURL
    case responseError
    case internetDown
    case unknown
    
}

extension YTNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "")
        case .internetDown:
            return NSLocalizedString("Internet Disconnected", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
