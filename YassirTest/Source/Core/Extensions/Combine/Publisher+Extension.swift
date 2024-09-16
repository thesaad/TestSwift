//
//  Publisher+Extension.swift
//  YassirTest
//
//  Created by Saad on 15/09/2024.
//

import Foundation
import Combine

extension Publisher {
    public func receiveAndCancel(receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void),
                                 receiveOutput: ((Output) -> Void)? = nil) {
        var cancellable: AnyCancellable? // Needs to be optional to avoid Swift syntax error
        cancellable = self.sink(receiveCompletion: {
            receiveCompletion($0)

            cancellable?.cancel()
        }, receiveValue: {
            receiveOutput?($0)
        })
    }

    public func receiveAndCancel(receiveOutput: ((Output) -> Void)? = nil,
                                 receiveError: ((Error) -> Void)? = nil) {
        receiveAndCancel(receiveCompletion: {
            if case .failure(let error) = $0 {
                receiveError?(error)
            }
        }, receiveOutput: receiveOutput)
    }

    public func sink(receiveError: ((Error) -> Void)? = nil,
                     receiveValue: @escaping (Output) -> Void) -> AnyCancellable {
        sink {
            if case .failure(let error) = $0 {
                receiveError?(error)
            }
        } receiveValue: {
            receiveValue($0)
        }
    }
}
