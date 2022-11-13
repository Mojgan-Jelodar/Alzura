//
//  Mock.swift
//  AlzuraTests
//
//  Created by Mozhgan on 11/13/22.
//

import Foundation
@testable import Alzura
extension Payment {
    static let mock : Payment = .init(id: 123, name: .cash, transaction: nil)
}

extension Currency {
    static let mock : Currency = .init(id: 1, code: "$", factor: 1)
}

extension Operator {
    static let mock : Operator = .init(id: 1, address: nil, ipAddress: nil, prices: nil, benefit: 0)
}
extension Customer {
    static let mock : Customer = .init(id: 234, prices: nil, benefit: 2.0)
}
extension Array where Element == Order {
    static let mock : [Order] = [.init(id: 724, createdAt: .now,
                                       updatedAt: .now, state: 90,
                                       payment: .mock,
                                       currency: .mock,
                                       sumOriginalPrice: 124,
                                       datumOperator: .mock,
                                       customer: .mock),
                                 .init(id: 110, createdAt: .now,
                                       updatedAt: .now, state: 90,
                                       payment: .mock,
                                       currency: .mock,
                                       sumOriginalPrice: 230,
                                       datumOperator: .mock,
                                       customer: .mock)]
}
extension OrdersResponse {
    static let mock = OrdersResponse(data: .mock, meta: .init(count: 2, limit: 1, offset: 0))
}
