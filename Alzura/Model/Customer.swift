//
//  Customer.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation

// MARK: - Customer
public struct Customer: Codable {
    let id: Int
    let prices: [Price]?
    let benefit: Double
}
