//
//  RestApiProtocol.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation

/// HTTP request methods.
public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
/// Type alias used for HTTP request headers.
public typealias ReaquestHeaders = [String: String]

public typealias RequestParameters = [String: Any]

public protocol ParameterEncoding {
    /// Creates a `URLRequest` by encoding parameters and applying them on the passed request.
    ///
    /// - Parameters:
    ///   - urlRequest: `URLRequestConvertible` value onto which parameters will be encoded.
    ///   - parameters: `Parameters` to encode onto the request.
    ///
    /// - Returns:      The encoded `URLRequest`.
    /// - Throws:       Any `Error` produced during parameter encoding.
    func encode(_ urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest
}

/// Protocol to which the HTTP requests must conform.
public protocol RequestProtocol {

    /// The path that will be appended to API's base URL.
    var path: String { get }

    /// The HTTP method.
    var method: RequestMethod { get }
    
    /// The Encoding
    var parameterEncoding : ParameterEncoding { get }

    /// The HTTP headers/
    var headers: ReaquestHeaders? { get }

    /// The request parameters used for query parameters for GET requests and in the HTTP body for POST, PUT and PATCH requests.
    var parameters: RequestParameters? { get }
}
