// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let customer = try? newJSONDecoder().decode(Customer.self, from: jsonData)

import Foundation

// MARK: - Operator
public struct Operator: Codable {
    let id: Int
    let address: Address?
    let ipAddress: String?
    let prices: [Price]?
    let benefit: Double

    enum CodingKeys: String, CodingKey {
        case id, address
        case ipAddress = "ip_address"
        case prices, benefit
    }
}
