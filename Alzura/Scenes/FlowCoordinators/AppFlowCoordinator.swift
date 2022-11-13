//
//  OrdersApiService.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
import UIKit
final class AppFlowCoordinator: FlowCoordinator {

    private let navigationController: UINavigationController
    private var childCoordinators = [FlowCoordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Creates all necessary dependencies and starts the flow
    var isLoggedIn : Bool {
        guard let info = AccessTokenStorage.shared.readCredential() else {
            return false
        }
        let dateDiff = Date(timeIntervalSince1970: info.expireAt) - Date()
        return dateDiff > .zero
    }
    
    func start() {
        if isLoggedIn {
            showMain()
        } else {
            showAuth()
        }
    }
    
    private func showAuth() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController ,
                                              dependencyProvider: LoginFactory(),
                                              delegate: self)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
    private func showMain() {
        let ordersCoordinator = OrdersCoordinator(navigationController: navigationController,
                                                dependencyProvider: OrdersFactory())
        ordersCoordinator.delegate = self
        childCoordinators.append(ordersCoordinator)
        ordersCoordinator.start()
        childCoordinators.removeAll { $0 is AuthCoordinator }
    }
}
extension AppFlowCoordinator : AuthCoordinatorDelegate {
    func didAuthenticate() {
        showMain()
    }
}
extension AppFlowCoordinator : OrdersCoordinatorDelegate {
    public func didLogout(coordinator: OrdersCoordinator) {
        showAuth()
    }
}
fileprivate extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
