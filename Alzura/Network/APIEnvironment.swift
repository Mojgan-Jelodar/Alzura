//
//  APIEnvironment.swift
//  TopStories
//
//  Created by Mozhgan on 8/27/22.
//

import Foundation

public protocol EnvironmentProtocol {
    /// The default HTTP request headers for the environment.
    var headers: ReaquestHeaders? { get }
    
    /// The base URL of the environment.
    var baseURL: String { get }
    
    /// API version number.
    var versionNumber : String { get }
}

enum APIEnvironment: EnvironmentProtocol {
    
    case development
    case production
    
    var headers: ReaquestHeaders? {
        return  ["Content-Type" :"application/json",
                 "Accept" : "application/vnd.saitowag.api+json;version=\(versionNumber)"]
    }
    
    var baseURL: String {
        return "https://api-b2b.alzura.com/"
    }
    
    var versionNumber: String {
        return "1.1"
    }
    
}
