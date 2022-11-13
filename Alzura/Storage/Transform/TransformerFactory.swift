//
//  TransformerFactory.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
import UIKit

public class TransformerFactory {
    public static func forData() -> Transformer<Data> {
        let toData: (Data) throws -> Data = { $0 }
        
        let fromData: (Data) throws -> Data = { $0 }
        
        return Transformer<Data>(toData: toData, fromData: fromData)
    }
    
    public static func forImage() -> Transformer<UIImage> {
        let toData: (UIImage) throws -> Data = { image in
            return try image.toData.unwrapOrThrow(error: StorageError.transformerFail)
        }
        
        let fromData: (Data) throws -> UIImage = { data in
            return try UIImage(data: data).unwrapOrThrow(error: StorageError.transformerFail)
        }
        
        return Transformer<UIImage>(toData: toData, fromData: fromData)
    }
    
    public static func forCodable<U: Codable>(ofType: U.Type) -> Transformer<U> {
        let toData: (U) throws -> Data = { object in
            let wrapper = TypeWrapper<U>(object: object)
            let encoder = JSONEncoder()
            return try encoder.encode(wrapper)
        }
        
        let fromData: (Data) throws -> U = { data in
            let decoder = JSONDecoder()
            return try decoder.decode(TypeWrapper<U>.self, from: data).object
        }
        
        return Transformer<U>(toData: toData, fromData: fromData)
    }
}
public extension Optional {
  func unwrapOrThrow(error: Error) throws -> Wrapped {
    if let value = self {
      return value
    } else {
      throw error
    }
  }
}
