//
//  Pub.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Combine
import Foundation

public extension Publisher where Self == URLSession.DataTaskPublisher {
    func validate() -> AnyPublisher<Data,APIError> {
        self
            .tryMap { (data: Data, response: URLResponse) in
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        if !data.isEmpty {
                            return data
                        } else {
                            throw APIError.responseUnsuccessful(statusCode: httpResponse.statusCode)
                        }
                    case 400...499:
                        throw APIError.requestFailed
                    case 500...599:
                        throw APIError.serverError
                    default:
                        throw APIError.responseUnsuccessful(statusCode: httpResponse.statusCode)
                    }
                } else {
                    throw APIError.unknown
                }
            }.mapError { error  in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.response(error: error)
                }
            }.eraseToAnyPublisher()
    }
}
