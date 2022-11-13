// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let payment = try? newJSONDecoder().decode(Payment.self, from: jsonData)

import Foundation

// MARK: - Payment
public struct Payment: Codable {
    enum Name: String, Codable {
        case applePay = "APPLE_PAY_ONSITE"
        case cash = "CASH"
        case creditCard = "CREDIT_CARD"
        case googlePay = "GOOGLE_PAY_ONSITE"
        case invoice = "INVOICE"
    }
    let id: Int
    let name: Name
    let transaction: Transaction?
}
