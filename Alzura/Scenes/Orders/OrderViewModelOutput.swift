//
//  OrderViewModelOutput.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
struct OrderViewModelOutput {
    let orderId : String
    let usedPayment : String
    let price : String
    let date : String
    
    static var emptyInit: OrderViewModelOutput {
        .init(orderId: "#-XXXX", usedPayment: "XXXX", price: "XXXX", date: "XX/XX/XXXX")
    }
}
extension OrderViewModelOutput : Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.orderId == rhs.orderId
    }
}
