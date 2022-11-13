//
//  APIRequestExecutor.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation

final public class APIRequestExecutor {
    /// The URLSession handing the URLSessionTaks.
    private  var session: URLSession!
    
    /// The environment configuration.
    private var environment: EnvironmentProtocol

    /// Designated initializer.
    /// - Parameters:
    ///   - environment: Instance conforming to `EnvironmentProtocol` used to determine on which
    ///   - configuration: `URLSessionConfiguration` instance.
    ///   - delegateQueue: `OperationQueue` instance for scheduling the delegate calls and completion handlers.
    public init(environment: EnvironmentProtocol,
                configuration: URLSessionConfiguration,
                delegateQueue: OperationQueue) {
        self.session = URLSession(configuration: configuration,
                                  delegate: nil,
                                  delegateQueue: delegateQueue)
        self.environment = environment
    }
    
    /// Executes a request.
    /// - Parameters:
    ///   - request: Instance conforming to `RequestProtocol`
    ///   - completion: Completion handler.
    func execute(request: RequestProtocol) -> URLSession.DataTaskPublisher {
        var urlRequest = request.urlRequest(with: environment)!
        let encodedRequest = try? request.parameterEncoding.encode(urlRequest, with: request.parameters)
        urlRequest = encodedRequest != nil ? encodedRequest! : urlRequest
        environment.headers?.forEach({ (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        return self.session.dataTaskPublisher(for: urlRequest)
    }

}

fileprivate extension RequestProtocol {

    /// Creates a URLRequest from this instance.
    /// - Parameter environment: The environment against which the `URLRequest` must be constructed.
    /// - Returns: An optional `URLRequest`.
    func urlRequest(with environment: EnvironmentProtocol) -> URLRequest? {
        // Create the base URL.
        guard let url = url(with: environment.baseURL) else {
            return nil
        }
        // Create a request with that URL.
        var request = URLRequest(url: url)

        // Append all related properties.
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }

    /// Creates a URL with the given base URL.
    /// - Parameter baseURL: The base URL string.
    /// - Returns: An optional `URL`.
    func url(with baseURL: String) -> URL? {
        // Create a URLComponents instance to compose the url.
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        // Add the request path to the existing base URL path
        urlComponents.path += path

        return urlComponents.url
    }

}
