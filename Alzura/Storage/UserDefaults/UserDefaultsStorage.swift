//
//  File.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation

final class UserDefaultsStorage<Value : Persistable> : PersistentStore {

    let transformer: Transformer<Value>
    init(transformer: Transformer<Value>) {
        self.transformer = transformer
    }
    
    func object(forKey key: String) throws -> Value {
        do {
            let data = try UserDefaults.standard.object(forKey: key).unwrapOrThrow(error: StorageError.notFound) as? Data
            return try transformer.fromData(data!)
        } catch let error {
            throw error
        }
    }
    
    func removeObject(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func setObject(_ object: Value, forKey key: String) throws {
        do {
            let toData = try transformer.toData(object)
            UserDefaults.standard.set(toData, forKey: key)
        } catch let error {
            throw error
        }
    }
}
