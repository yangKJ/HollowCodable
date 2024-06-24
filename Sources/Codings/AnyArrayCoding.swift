//
//  AnyArrayCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/24.
//

import Foundation

public struct AnyArray: Transformer, HasDefaultValuable {
    
    let array: [AnyDictionaryType]
    
    public typealias DecodeType = [[String: Any]]
    public typealias EncodeType = [AnyDictionaryType]
    
    public static var hasDefaultValue: [[String: Any]] {
        []
    }
    
    public init?(value: Any) {
        guard let array = value as? [AnyDictionaryType] else {
            return nil
        }
        self.array = array
    }
    
    public func transform() throws -> [[String: Any]]? {
        array.compactMap {
            $0.mapValues(\.value) as? [String: Any]
        }
    }
    
    public static func transform(from value: [[String: Any]]) throws -> [AnyDictionaryType] {
        value.map {
            $0.compactMapValues(AnyDictionaryValue.init(value:))
        }
    }
}
