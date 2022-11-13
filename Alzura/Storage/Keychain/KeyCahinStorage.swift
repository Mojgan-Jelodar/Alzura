//
//  KeyCahinStorage.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
final class KeyCahinStorage<Value : Persistable> : PersistentStore {
    let transformer: Transformer<Value>
    init(transformer: Transformer<Value>) {
        self.transformer = transformer
    }
    
    func object(forKey key: String) throws -> Value {
        do {
            let data = try SecureStore.standard.getValue(for: key).unwrapOrThrow(error: StorageError.notFound)
            return try transformer.fromData(data)
        } catch let error {
            throw error
        }
    }
    
    func removeObject(forKey key: String) {
        try? SecureStore.standard.remove(for: key)
    }
    
    func setObject(_ object: Value, forKey key: String) throws {
        do {
            let toData = try transformer.toData(object)
            try SecureStore.standard.setValue(toData, for: key)
        } catch let error {
            throw error
        }
    }
}
extension KeyCahinStorage {
    static func removeAll() {
        let secItemClasses = [kSecClassGenericPassword,
                              kSecClassInternetPassword,
                              kSecClassCertificate,
                              kSecClassKey,
                              kSecClassIdentity]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
}
