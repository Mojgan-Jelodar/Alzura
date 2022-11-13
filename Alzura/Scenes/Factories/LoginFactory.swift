//
//  AuthenticatorFactory.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
import UIKit

protocol LoginFlowCoordinatorDependencyProvider {
    func loginViewController(navigator: LoginNavigatorInterface) -> LoginViewController
}

struct LoginFactory {
    
}

extension LoginFactory : LoginFlowCoordinatorDependencyProvider {
    
    func loginViewController(navigator: LoginNavigatorInterface) -> LoginViewController {
        let viewModel = LoginViewModel(navigator: navigator,
                                       loginService: LoginNetworkManager.default,
                                       tokenStorage: AccessTokenStorage.shared)
        return LoginViewController(viewModel: viewModel)
    }
}
