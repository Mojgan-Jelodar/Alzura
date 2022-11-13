//
//  LoginNetworkManager.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
import Combine
public protocol LoginNetworkManagerProtocol {
    func login(username: String,password : String) -> AnyPublisher<LoginResponse,APIError>
}
extension LoginNetworkManager {
    static let `default` = LoginNetworkManager(environment: .production, configuration: .default)
}

public final class LoginNetworkManager : LoginNetworkManagerProtocol {
    
    private let requestExecutor : APIRequestExecutor
    
    let operationQueue : OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    init(environment: APIEnvironment, configuration: URLSessionConfiguration) {
        self.requestExecutor = .init(environment: environment, configuration: configuration, delegateQueue: operationQueue)
    }
    
    public func login(username: String,password : String) -> AnyPublisher<LoginResponse,APIError> {
        requestExecutor
            .execute(request: SessionAPIService.login(input: .init(username: username, password: password)))
            .validate()
            .decode(using: .init())
    }
}
