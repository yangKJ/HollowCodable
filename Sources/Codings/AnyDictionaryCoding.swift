//
//  AnyDictionaryCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/23.
//

import Foundation

public struct AnyDictionary: Transformer, HasDefaultValuable {
    
    let dict: AnyDictionaryType
    
    public typealias DecodeType = [String: Any]
    public typealias EncodeType = AnyDictionaryType
    
    public static var hasDefaultValue: [String: Any] {
        [:]
    }
    
    public init?(value: Any) {
        guard let dict = value as? AnyDictionaryType else {
            return nil
        }
        self.dict = dict
    }
    
    public func transform() throws -> [String: Any]? {
        dict.mapValues(\.value) as? [String: Any]
    }
    
    public static func transform(from value: [String: Any]) throws -> AnyDictionaryType {
        value.compactMapValues(AnyDictionaryValue.init(value:))
    }
}
