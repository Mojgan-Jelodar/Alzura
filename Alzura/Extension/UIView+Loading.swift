//
//  UIView.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import UIKit
private let loadingTag = Int.max
extension UIView {
    
    var isAnimated: Bool {
        get {
            viewWithTag(loadingTag) != nil
        }
        set {
            newValue ? lock() : unlock()
        }
    }
     
//     var isAnimated : Bool {
//         get {
//             let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
//             return UIViewController._myComputedProperty[tmpAddress] ?? false
//         }
//         set(newValue) {
//             let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
//             UIViewController._myComputedProperty[tmpAddress] = newValue
//         }
//     }
//    var isAnimated : Bool = false {
//        didSet {
//            if isAnimated {
//                startAnimating()
//            } else {
//                stopAnimating()
//            }
//        }
//    }
    
    private func lock() {
        if let activityIndicatorView = viewWithTag(loadingTag) as? UIActivityIndicatorView {
            activityIndicatorView.startAnimating()
        } else {
            let activityIndicatorView = UIActivityIndicatorView(style: .medium)
            activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.tag = loadingTag
            activityIndicatorView.tintAdjustmentMode = .dimmed
            activityIndicatorView.tintColor = .label
            activityIndicatorView.backgroundColor = .black.withAlphaComponent(0.4)
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(activityIndicatorView)
            addConstraints([.init(item: activityIndicatorView, attribute: .centerX,
                                  relatedBy: .equal, toItem: self, attribute: .centerX,
                                  multiplier: 1, constant: 0),
                            .init(item: activityIndicatorView, attribute: .centerY,
                                  relatedBy: .equal, toItem: self,
                                  attribute: .centerY, multiplier: 1, constant: 0),
                            .init(item: activityIndicatorView, attribute: .width,
                                  relatedBy: .equal, toItem: self,
                                  attribute: .width, multiplier: 1, constant: 0),
                            .init(item: activityIndicatorView, attribute: .height,
                                  relatedBy: .equal, toItem: self,
                                  attribute: .height, multiplier: 1, constant: 0)])
            activityIndicatorView.startAnimating()
        }
  
    }
    
    private func unlock() {
        if let activityIndicatorView = viewWithTag(loadingTag) as? UIActivityIndicatorView {
            activityIndicatorView.stopAnimating()
        }
    }
}
