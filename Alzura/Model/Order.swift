// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datum = try? newJSONDecoder().decode(Datum.self, from: jsonData)

import Foundation

// MARK: - Datum
public struct Order: Codable {
    let id: Int
    let createdAt, updatedAt: Date
    let state: Int
    let payment: Payment
    let currency: Currency
    let sumOriginalPrice: Double
    let datumOperator : Operator
    let customer: Customer
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case state, payment, currency
        case sumOriginalPrice = "sum_original_price"
        case datumOperator = "operator"
        case customer
    }
}
extension Order  : Equatable {
    public static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }
}
