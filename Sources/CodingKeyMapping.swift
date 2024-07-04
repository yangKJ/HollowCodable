//
//  CodingKeyMapping.swift
//  CodableExample
//
//  Created by Condy on 2024/7/4.
//

import Foundation

public protocol CodingKeyMapping {
    var keyString: String { get set }
}

extension CodingKeyMapping {
    
    public var key: CodingKey {
        PathCodingKey(stringValue: keyString)
    }
}
