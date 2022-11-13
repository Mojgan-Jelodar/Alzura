//
//  LoginResponse.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import Foundation
// MARK: - LoginResponse
public struct LoginResponse: Codable {
    let data: LoginData
}

// MARK: - LoginData
public struct LoginData: Codable,Persistable {
    let firebaseToken: String
    let firebaseExpireAt: Int
    let token: String
    let expireAt: Double
    let forcePasswordReset: Bool

    enum CodingKeys: String, CodingKey {
        case firebaseToken = "firebase_token"
        case firebaseExpireAt = "firebase_expire_at"
        case token
        case expireAt = "expire_at"
        case forcePasswordReset = "force_password_reset"
    }
}
