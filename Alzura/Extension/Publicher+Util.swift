//
//  Publicher+Util.swift
//  Alzura
//
//  Created by Mozhgan on 11/11/22.
//

import Foundation
import Combine

extension Publisher {
    
    // MARK: - Combine
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
        
    }
}
