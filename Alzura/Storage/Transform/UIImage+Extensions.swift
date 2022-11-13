//
//  TransformerFactory.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import UIKit

extension UIImage {
  /// Checks if image has alpha component
  var hasAlpha: Bool {
    let result: Bool

    guard let alpha = cgImage?.alphaInfo else {
      return false
    }

    switch alpha {
    case .none, .noneSkipFirst, .noneSkipLast:
      result = false
    default:
      result = true
    }

    return result
  }

  /// Convert to data
    var toData : Data? {
      return hasAlpha
        ? pngData()
        : jpegData(compressionQuality: 1.0)
    }
}
