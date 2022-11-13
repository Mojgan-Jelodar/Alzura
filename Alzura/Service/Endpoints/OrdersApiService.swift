//
//  OrdersApiService.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
enum OrdersApiService : RequestProtocol {
    case orders(input : OrderInput)
    var path: String {
        switch self {
        case .orders :
            return "operator/orders"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .orders:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: ReaquestHeaders? {
        switch self {
        case .orders:
            return ["X-AUTH-TOKEN" : AccessTokenStorage.shared.readCredential()?.token ?? ""]
        }
    }
    
    var parameters: RequestParameters? {
        switch self {
        case .orders(let  input):
            return ["limit": input.limit,
                    "offset" : input.offset,
                    "sort" : input.sort.description]
        }
    }
}
