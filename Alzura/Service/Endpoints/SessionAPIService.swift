//
//  SessionAPIService.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
enum SessionAPIService : RequestProtocol {
    case login(input : LoginInput)
    var path: String {
        switch self {
        case .login :
            return "operator/login"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JsonEncoding.default
    }
    
    var headers: ReaquestHeaders? {
        switch self {
        case .login(let input):
            let loginString = String(format: "%@:%@", input.username, input.password)
            return ["Authorization" : "Basic \(loginString.toBase64())"]
        }
    }
    
    var parameters: RequestParameters? {
        switch self {
        case .login:
            return nil
        }
    }
}
