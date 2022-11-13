//
//  OrdersNetworkManager.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
import Combine

public protocol OrdersNetworkManagerProtocol {
    func fetchOrders(order : OrderInput) -> AnyPublisher<OrdersResponse,APIError>
}
extension OrdersNetworkManager {
    static let `default` = OrdersNetworkManager(environment: .production, configuration: .default)
}

public final class OrdersNetworkManager : OrdersNetworkManagerProtocol {
    
    private let requestExecutor : APIRequestExecutor
    
    let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    private lazy var decoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    let operationQueue : OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    init(environment: APIEnvironment, configuration: URLSessionConfiguration) {
        self.requestExecutor = .init(environment: environment, configuration: configuration,
                                     delegateQueue: operationQueue)
    }
    
    public func fetchOrders(order: OrderInput) -> AnyPublisher<OrdersResponse, APIError> {
        self.requestExecutor
            .execute(request: OrdersApiService.orders(input: order))
            .validate()
            .decode(using: decoder)
    }
}
