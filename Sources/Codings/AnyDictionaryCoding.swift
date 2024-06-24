//
//  AnyDictionaryCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/23.
//

import Foundation

public struct AnyDictionary: Transformer, HasDefaultValuable {
    
    let dict: [String: AnyDictionaryValue]
    
    public typealias DecodeType = [String: Any]
    public typealias EncodeType = [String: AnyDictionaryValue]
    
    public static var hasDefaultValue: [String: Any] {
        Dictionary<String, Any>()
    }
    
    public init?(value: Any) {
        guard let dict = value as? [String: AnyDictionaryValue] else {
            return nil
        }
        self.dict = dict
    }
    
    public func transform() throws -> [String: Any]? {
        dict.mapValues(\.value) as? [String: Any]
    }
    
    public static func transform(from value: [String: Any]) throws -> [String: AnyDictionaryValue] {
        value.compactMapValues(AnyDictionaryValue.init(value:))
    }
}

public enum AnyDictionaryValue {
    case null
    case string(String)
    case int(Int)
    case float(Float)
    case bool(Bool)
    case double(Double)
    case date(Date)
    case data(Data)
    indirect case array([AnyDictionaryValue])
    indirect case dictionary([String: AnyDictionaryValue])
}

extension AnyDictionaryValue: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let int = try? container.decode(Int.self) {
            self = .int(int)
        } else if let float = try? container.decode(Float.self) {
            self = .float(float)
        } else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let double = try? container.decode(Double.self) {
            self = .double(double)
        } else if let date = try? container.decode(Date.self) {
            self = .date(date)
        } else if let data = try? container.decode(Data.self) {
            self = .data(data)
        } else if let dict = try? container.decode([String:AnyDictionaryValue].self) {
            self = .dictionary(dict)
        } else if let array = try? container.decode([AnyDictionaryValue].self) {
            self = .array(array)
        } else {
            self = .null
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case .dictionary(let dict):
            try container.encode(dict)
        case .array(let array):
            try container.encode(array)
        case .string(let string):
            try container.encode(string)
        case .int(let int):
            try container.encode(int)
        case .float(let float):
            try container.encode(float)
        case .bool(let bool):
            try container.encode(bool)
        case .double(let double):
            try container.encode(double)
        case .date(let date):
            try container.encode(date)
        case .data(let data):
            try container.encode(data)
        }
    }
    
    var value: Any? {
        switch self {
        case .null:
            return nil
        case .dictionary(let value):
            return value
        case .array(let value):
            return value
        case .string(let value):
            return value
        case .int(let value):
            return value
        case .float(let value):
            return value
        case .bool(let value):
            return value
        case .double(let value):
            return value
        case .date(let value):
            return value
        case .data(let value):
            return value
        }
    }
    
    init?(value: Any) {
        switch value {
        case Optional<Any>.none:
            self = .null
        case let val as [String: AnyDictionaryValue]:
            self = .dictionary(val)
        case let val as [AnyDictionaryValue]:
            self = .array(val)
        case let val as String:
            self = .string(val)
        case let val as Int:
            self = .int(val)
        case let val as Float:
            self = .float(val)
        case let val as Bool:
            self = .bool(val)
        case let val as Double:
            self = .double(val)
        case let val as Data:
            self = .data(val)
        case let val as Date:
            self = .date(val)
        default:
            return nil
        }
    }
}
