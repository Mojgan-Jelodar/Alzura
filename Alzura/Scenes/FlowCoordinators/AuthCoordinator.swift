//
//  AuthCoordinator.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
import UIKit
public enum LoginViewDesination : Equatable {
    case orders
    public static func == (lhs: LoginViewDesination, rhs: LoginViewDesination) -> Bool {
        switch (lhs,rhs) {
        case (.orders,.orders):
            return true
        }
    }
}
public protocol LoginNavigatorInterface : AnyObject {
    func routeTo(desination : LoginViewDesination)
}

public protocol AuthCoordinatorDelegate : AnyObject {
    func didAuthenticate()
}
final public class AuthCoordinator : FlowCoordinator {
    private weak var delegate : AuthCoordinatorDelegate?
    private let navigationController: UINavigationController
    private let dependencyProvider: LoginFlowCoordinatorDependencyProvider
    init(navigationController : UINavigationController,
         dependencyProvider: LoginFlowCoordinatorDependencyProvider,
         delegate: AuthCoordinatorDelegate? = nil) {
        self.delegate = delegate
        self.navigationController = navigationController
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let vc = dependencyProvider.loginViewController(navigator: self)
        self.navigationController.setViewControllers([vc], animated: true)
    }
}
extension AuthCoordinator : LoginNavigatorInterface {
    public func routeTo(desination: LoginViewDesination) {
        switch desination {
        case .orders:
            self.delegate?.didAuthenticate()
        }
    }
}
