//
//  StorageProtocol.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
public protocol Persistable {}
extension String    : Persistable {}
extension Int        : Persistable {}
extension Double    : Persistable {}
extension Bool        : Persistable {}
extension Data        : Persistable {}

public protocol PersistentStore {
    associatedtype Value : Persistable
    
    func object(forKey key: String) throws  -> Value
    func removeObject(forKey key: String)
    func setObject(_ object: Value, forKey key: String)  throws
    
}
