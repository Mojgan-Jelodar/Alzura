// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let price = try? newJSONDecoder().decode(Price.self, from: jsonData)

import Foundation

// MARK: - Price
public struct Price: Codable {
    let gross: Double
    let net: Double
    let tax: Tax
}
