//
//  LoginViewModel.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import Combine

enum LoginViewEvent {
    case login
}
enum LoginViewState {
    case isLoading
    case failed(error : Error)
    case loaded
}

protocol LoginViewModelInput {
    func transform(viewEvent : LoginViewEvent)
    var isValid :Bool { get }
}

protocol LoginViewModelOutput {
    var viewState: AnyPublisher<LoginViewState, Never> { get }
    var brokenRules :[String] { get set}
}

protocol LoginViewModelProtocol: LoginViewModelInput, LoginViewModelOutput { }

class LoginViewModel: LoginViewModelProtocol {
    
    var isValid: Bool {
        self.brokenRules.removeAll(keepingCapacity: false)
        self.validate()
        return brokenRules.isEmpty
    }
    
    var brokenRules: [String] = .init()
    
    var viewState: AnyPublisher<LoginViewState, Never> {
        viewStateSubject.eraseToAnyPublisher()
    }
    var username : String?
    var password : String?
    
    // MARK: - Private properties
    private weak var navigator : LoginNavigatorInterface?
    private var viewStateSubject : PassthroughSubject<LoginViewState, Never> = .init()
    private let loginService : LoginNetworkManagerProtocol
    private var tokenStorage : AccessTokenProtocol
    private var subscribers : Set<AnyCancellable> = .init()
    
    // MARK: - OUTPUT
    init(navigator: LoginNavigatorInterface?,
         loginService: LoginNetworkManagerProtocol,
         tokenStorage : AccessTokenProtocol) {
        self.navigator = navigator
        self.loginService = loginService
        self.tokenStorage = tokenStorage
    }
    
    private func validate() {
        guard let username = username,let password = password else {
            brokenRules.append(R.string.login.emptyCredentialsError())
            return
        }
        guard !username.isEmpty && !password.isEmpty else {
            brokenRules.append(R.string.login.emptyCredentialsError())
            return
        }
    }
    
    private func write(credential : LoginData) {
        do {
            try tokenStorage.write(credential: credential)
        } catch let error {
            viewStateSubject.send(.failed(error: error))
        }
    }
}

// MARK: - INPUT. View event methods
extension LoginViewModel {
    func transform(viewEvent: LoginViewEvent) {
        switch viewEvent {
        case .login:
            viewStateSubject.send(.isLoading)
            loginService
                .login(username: username!, password: password!)
                .receive(on: DispatchQueue.main)
                .sinkToResult { [weak self] result in
                    self?.viewStateSubject.send(.loaded)
                    switch result {
                    case .success(let loginResponse) :
                        self?.write(credential: loginResponse.data)
                        self?.navigator?.routeTo(desination: .orders)
                    case .failure(let error):
                        self?.viewStateSubject.send(.failed(error: error))
                    }
                }
                .store(in: &subscribers)
        }
    }
}
