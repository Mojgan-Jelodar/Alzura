// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let address = try? newJSONDecoder().decode(Address.self, from: jsonData)

import Foundation

// MARK: - Address
public struct Address: Codable {
    let salutation: Int
    let firstName, lastName, company, street: String
    let postcode, city: String
    let floor, country: Int

    enum CodingKeys: String, CodingKey {
        case salutation
        case firstName = "first_name"
        case lastName = "last_name"
        case company, street, postcode, city, floor, country
    }
}
