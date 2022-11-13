//
//  OrderInput.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation

enum SortedKey : CustomStringConvertible {
    
    case updatedAt(isAscending: Bool)
    var description: String {
        let orderingAsc = "+"
        let orderingDesc = "-"
        switch self {
        case .updatedAt(let isAscending):
            let ordering = isAscending ? orderingAsc : orderingDesc
            return [ordering,"updated_at"].joined()
        }
    }
}
public struct OrderInput {
    let limit : Int
    let offset : Int
    let sort : SortedKey
}
