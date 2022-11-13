//
//  OrdersCoordinator.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
import UIKit
public enum OrdersViewDesination : Equatable {
    case detail(order : Order)
    case logout
    public static func == (lhs: OrdersViewDesination, rhs: OrdersViewDesination) -> Bool {
        switch (lhs,rhs) {
        case (.logout,.logout) :
            return true
        case  (.detail(let lhsOrder),.detail(order: let rhsOrder)) :
            return lhsOrder == rhsOrder
        default :
            return false
        }
    }
}
public protocol OrdersCoordinatorDelegate: AnyObject {
    func didLogout(coordinator: OrdersCoordinator)
}

public protocol OrdersNavigatorInterface : AnyObject {
    func routeTo(desination : OrdersViewDesination)
}

final public class OrdersCoordinator : FlowCoordinator {
    let navigationController: UINavigationController
    let dependencyProvider : DependencyProvider
    weak var delegate: OrdersCoordinatorDelegate?
    typealias DependencyProvider =  OrdersFlowCoordinatorDependencyProvider
    
    init(navigationController: UINavigationController,
         dependencyProvider : DependencyProvider) {
        self.navigationController = navigationController
        self.dependencyProvider = dependencyProvider
    }

    func start() {
        let vc = dependencyProvider.orderListViewController(navigator: self)
        navigationController.setViewControllers([vc], animated: false)
    }
}
extension OrdersCoordinator : OrdersNavigatorInterface {
    public func routeTo(desination: OrdersViewDesination) {
        switch desination {
        case .detail(let order):
            navigationController.pushViewController(dependencyProvider.orderDetailViewController(order: order), animated: true)
        case .logout:
            delegate?.didLogout(coordinator: self)
        }
    }
}
