//
//  JsonEncoding.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
struct JsonEncoding : ParameterEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: RequestParameters?) throws -> URLRequest {
        var urlRequest = urlRequest
        guard let parameters = parameters else { return urlRequest }
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        return urlRequest
    }
}
extension JsonEncoding {
    static let `default` = JsonEncoding()
}
