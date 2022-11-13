//
//  AccessTokenStorage.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
protocol AccessTokenProtocol {
    func readCredential() -> LoginData?
    func clear()
    mutating func write(credential : LoginData) throws
}

struct AccessTokenStorage : AccessTokenProtocol {
    
    typealias Object = LoginData
    
    fileprivate enum AccessTokenKey : String {
        case loginInfo
    }
    
    private let storageService : KeyCahinStorage = .init(transformer: TransformerFactory.forCodable(ofType: Object.self))
    private var loginInfo : LoginData?
    
    private init() {
        loginInfo = try? storageService.object(forKey: AccessTokenKey.loginInfo.rawValue)
    }
    
    static var shared = AccessTokenStorage()
    
    func readCredential() -> LoginData? {
        loginInfo
    }
    
    mutating func write(credential : LoginData) throws {
        loginInfo = credential
        try storageService.setObject(credential, forKey: AccessTokenKey.loginInfo.rawValue)
    }
    
    func clear() {
        storageService.removeObject(forKey: AccessTokenKey.loginInfo.rawValue)
    }
    
}
