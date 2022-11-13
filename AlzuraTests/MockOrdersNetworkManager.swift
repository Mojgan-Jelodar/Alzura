//
//  MockOrdersNetworkManager.swift
//  AlzuraTests
//
//  Created by Mozhgan on 11/13/22.
//

import Foundation
import XCTest
import Combine
@testable import Alzura

final class MockOrdersNetworkManager : OrdersNetworkManagerProtocol {
    var value : Result<Alzura.OrdersResponse, Alzura.APIError> = .failure(.unknown)
    func fetchOrders(order: Alzura.OrderInput) -> AnyPublisher<Alzura.OrdersResponse, Alzura.APIError> {
        switch value {
        case .success(let value):
            return Just<OrdersResponse>(value).setFailureType(to: APIError.self).eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
