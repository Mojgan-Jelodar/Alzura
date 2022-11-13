//
//  OrdersFactory.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation

import UIKit
protocol OrdersFlowCoordinatorDependencyProvider {
    func orderDetailViewController(order : Order) -> UIViewController
    func orderListViewController(navigator :OrdersNavigatorInterface) -> OrdersViewController
}

struct OrdersFactory {
    
}

extension OrdersFactory : OrdersFlowCoordinatorDependencyProvider {
    func orderDetailViewController(order: Order) -> UIViewController {
        return .init()
    }
    
    func orderListViewController(navigator :OrdersNavigatorInterface) -> OrdersViewController {
        let viewModel = OrdersViewModel(navigator: navigator,
                                        ordersNetworkManager: OrdersNetworkManager.default)
        return OrdersViewController(viewModel: viewModel)
    }
    
}
