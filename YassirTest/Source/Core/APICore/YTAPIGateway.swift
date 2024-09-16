//
//  YTAPIGateway.swift
//  YassirTest
//
//  Created by Saad on 15/09/2024.
//

import Foundation
import Combine

class YTAPIGateway: NSObject {
    /// For check internet connection
    private let reachabilityProvider: ReachabilityProvider
    
    override init() {
        reachabilityProvider = ReachabilityProvider()
        super.init()

    }
    // MARK: API Default Methods GET, POST

    /// Performs the query fetch from the server
    ///
    ///  - parameters:
    ///     - query: The query to fetch
    ///     - callbackQueue: The dispatch queue to receive data on
    ///
    ///  - returns: A publisher of the query data or error
    ///
    func get<T: Decodable>(url: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: url) else {
            return Fail(error: NSError(domain: "Invalid URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        guard reachabilityProvider.hasConnection else {
            return Fail(error: YTNetworkError.internetDown).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw YTNetworkError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }

    /// Performs the mutation on the server
    ///
    ///  - parameters:
    ///     - mutation: The mutation to perform
    ///     - callbackQueue: The dispatch queue to receive data on
    ///
    ///  - returns: A publisher of the mutation data or error
    ///
//    func perform<Mutation: GraphQLMutation>(mutation: Mutation,
//                                            callbackQueue: DispatchQueue = .global(qos: .userInitiated))
//        -> AnyPublisher<Mutation.Data, Error> {
//        Future<Mutation.Data, Error> { [weak self] promise in
//
//            guard let self else {
//                return
//            }
//
//            let traceGroup = DispatchGroup()
//
//            func perform() {
//                traceGroup.enter()
//                self.client.perform(mutation: mutation, queue: callbackQueue) { response in
//                    let result = self.handleGraphQLResponse(response)
//
//                    promise(result)
//                    traceGroup.leave()
//                }
//            }
//
//            let tracableOperation = perform
//            let traceCompletion = self.traceOperation(for: tracableOperation,
//                                                 traceName: mutation.operationName)
//            traceGroup.notify(queue: .global(qos: .utility),
//                              work: traceCompletion)
//
//        }.eraseToAnyPublisher()
//    }
    
//     func getData<T: Decodable>(endpoint: String, id: Int? = nil, type: T.Type) -> Future<T, Error> {
//        return Future<T, Error> { [weak self] promise in  // (4) -> Future Publisher
//            guard let self = self, let url = URL(string: endpoint) else {
//                return promise(.failure(NetworkError.invalidURL))
//            }
//            print("URL is \(url.absoluteString)")
//            URLSession.shared.dataTaskPublisher(for: url) // (5) -> Publisher
//                .tryMap { (data, response) -> Data in  // (6) -> Operator
//                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
//                        throw NetworkError.responseError
//                    }
//                    return data
//                }
//                .decode(type: T.self, decoder: JSONDecoder())  // (7) -> Operator
//                .receive(on: RunLoop.main) // (8) -> Sheduler Operator
//                .sink(receiveCompletion: { (completion) in  // (9) -> Subscriber
//                    if case let .failure(error) = completion {
//                        switch error {
//                        case let decodingError as DecodingError:
//                            promise(.failure(decodingError))
//                        case let apiError as NetworkError:
//                            promise(.failure(apiError))
//                        default:
//                            promise(.failure(NetworkError.unknown))
//                        }
//                    }
//                }, receiveValue: {  data in  // (10)
//                    print(data)
//                    promise(.success(data)
//    ) })
//                .store(in: &self.cancellables)  // (11)
//        }
//    }
//    func paramString(params: [String: String]) -> String {
//        var result = String()
//        for (key, value) in params {
//            if !result.isEmpty {
//                result.append("&")
//            }
//            result.append("\(key)=\(value)")
//        }
//    }

}
