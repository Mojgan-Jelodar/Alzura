//
//  TypeWrapper.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
public struct TypeWrapper<T: Codable>: Codable {
  enum CodingKeys: String, CodingKey {
    case object
  }

  public let object: T

  public init(object: T) {
    self.object = object
  }
}
