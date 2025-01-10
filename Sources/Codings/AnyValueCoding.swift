//
//  AnyValueCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/23.
//

import Foundation

/// Support any value property wrapper.
/// `@AnyValueCoding` decodes any value json into `Any`、`[Any]`、`[String: Any]`.
public struct AnyValue<T>: Transformer {
    
    let anyValue: CodableAnyValue
    
    public typealias DecodeType = T
    public typealias EncodeType = CodableAnyValue
    
    public static var useCodableAnyValueDecoding: Bool {
        true
    }
    
    public init?(value: Any) {
        guard let value = value as? CodableAnyValue else {
            return nil
        }
        self.anyValue = value
    }
    
    public func transform() throws -> T? {
        return anyValue.value as? T
    }
    
    public static func transform(from value: T) throws -> CodableAnyValue {
        CodableAnyValue.init(value: value) ?? .null
    }
}
