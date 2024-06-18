//
//  KeyStrategy.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

extension JSONEncoder {
    
    func setupKeyStrategy<T: HollowCodable>(_ type: T.Type) {
        let mapKeys = T.codingKeys
        guard !mapKeys.isEmpty else {
            return
        }
        let mapping = mapKeys.toEncoderingMappingKeys
        self.keyEncodingStrategy = .custom({ codingPath in
            let key = codingPath.last!.stringValue
            if let mapped = mapping[key] {
                return PathCodingKey(stringValue: mapped)
            } else {
                return PathCodingKey(stringValue: key)
            }
        })
    }
}

extension JSONDecoder {
    
    func setupKeyStrategy<T: HollowCodable>(_ type: T.Type) {
        let mapKeys = T.codingKeys
        guard !mapKeys.isEmpty else {
            return
        }
        let mapping = mapKeys.toDecoderingMappingKeys
        self.keyDecodingStrategy = .custom({ codingPath in
            let key = codingPath.last!.stringValue
            if let mapped = mapping[key] {
                return PathCodingKey(stringValue: mapped)
            } else {
                return PathCodingKey(stringValue: key)
            }
        })
    }
}
