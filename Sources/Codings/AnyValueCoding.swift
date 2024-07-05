//
//  AnyValueCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/23.
//

import Foundation

/// Support any value property wrapper with dictionary(`[String: Any]`).
/// `@DictionaryCoding` decodes any value json into `[String: Any]`.
public struct AnyDictionary: Transformer, HasDefaultValuable {
    
    let dict: [String: JSONValue]
    
    public typealias DecodeType = [String: Any]
    public typealias EncodeType = [String: JSONValue]
    
    public static var hasDefaultValue: [String: Any] {
        [:]
    }
    
    public init?(value: Any) {
        guard let value = value as? JSONValue else {
            return nil
        }
        switch value {
        case .dictionary(let res):
            self.dict = res
        default:
            return nil
        }
    }
    
    public func transform() throws -> [String: Any]? {
        dict.mapValues(\.value) as? [String: Any]
    }
    
    public static func transform(from value: [String: Any]) throws -> [String: JSONValue] {
        value.compactMapValues(JSONValue.init(value:))
    }
}

/// Support any value dictionary property wrapper with array(`[[String: Any]]`).
/// `@ArrayCoding` decodes any value json into `[[String: Any]]`.
public struct AnyDictionaryArray: Transformer, HasDefaultValuable {
    
    let array: [[String: JSONValue]]
    
    public typealias DecodeType = [[String: Any]]
    public typealias EncodeType = [[String: JSONValue]]
    
    public static var hasDefaultValue: [[String: Any]] {
        []
    }
    
    public init?(value: Any) {
        guard let value = value as? JSONValue else {
            return nil
        }
        switch value {
        case .array(let res):
            let array = res.compactMap({
                if case .dictionary(let dict) = $0 {
                    return dict
                }
                return nil
            })
            guard !array.isEmpty else {
                return nil
            }
            self.array = array
        default:
            return nil
        }
    }
    
    public func transform() throws -> [[String: Any]]? {
        array.compactMap {
            $0.mapValues(\.value) as? [String: Any]
        }
    }
    
    public static func transform(from value: [[String: Any]]) throws -> [[String: JSONValue]] {
        value.map {
            $0.compactMapValues(JSONValue.init(value:))
        }
    }
}

/// Support any value property wrapper with Any.
/// `@AnyXCoding` decodes any value json into `Any`.
public struct AnyX: Transformer {
    
    let value: JSONValue
    
    public typealias DecodeType = Any
    public typealias EncodeType = JSONValue
    
    public init?(value: Any) {
        guard let value = value as? JSONValue else {
            return nil
        }
        self.value = value
    }
    
    public func transform() throws -> Any? {
        value.value
    }
    
    public static func transform(from value: Any) throws -> JSONValue {
        guard let value = JSONValue.init(value: value) else {
            let userInfo = [
                NSLocalizedDescriptionKey: "The any to routine value is nil."
            ]
            throw NSError(domain: "com.condy.hollow.codable", code: -100014, userInfo: userInfo)
        }
        return value
    }
}
