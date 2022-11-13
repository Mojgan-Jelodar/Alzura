// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ordersResponse = try? newJSONDecoder().decode(OrdersResponse.self, from: jsonData)

import Foundation

// MARK: - OrdersResponse
public struct OrdersResponse: Codable {
    let data: [Order]
    let meta: Meta
}
