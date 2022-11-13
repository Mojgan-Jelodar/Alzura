// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currency = try? newJSONDecoder().decode(Currency.self, from: jsonData)

import Foundation

// MARK: - Currency
public struct Currency: Codable {
    let id: Int
    let code: String
    let factor: Double
}
