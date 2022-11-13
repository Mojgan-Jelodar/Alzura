//
//  ApiError.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
public enum APIError: Error,Equatable {
    
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case serverError
    case jsonParsingFailure(reason : String)
    case response(error : Error)
    case unknown
    
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs,rhs) {
        case (.requestFailed,.requestFailed),
            (.serverError,.serverError),
            (.unknown,.unknown) :
            return true
        case (.responseUnsuccessful(let left),.responseUnsuccessful(let right)):
            return left == right
        case (.response(let left),.response(let right)):
            return left.localizedDescription == right.localizedDescription
        default : return false
        }
    }
    
}
