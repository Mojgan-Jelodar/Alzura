// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tax = try? newJSONDecoder().decode(Tax.self, from: jsonData)

import Foundation

// MARK: - Tax
public struct Tax: Codable {
    let rate: Int
    let type: String
    let value: Double
}
