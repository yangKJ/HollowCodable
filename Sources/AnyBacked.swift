//
//  AnyBacked.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

/// Support `Int`、`UInt`、`Float`、`CGFloat`、`Double`、`TimeInterval`、`String`、`Bool`、`Int64`、`UInt64`
/// Or that implements the `StringRepresentable` protocol object.
@propertyWrapper public struct AnyBacked<T: StringRepresentable>: Codable {
    
    public var wrappedValue: T?
    
    public init(_ wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try AnyBackedDecoding<T>.init(from: decoder).wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try AnyBackedEncoding<T>(wrappedValue).encode(to: encoder)
    }
}

@propertyWrapper public struct AnyBackedDecoding<T: StringRepresentable>: Decodable {
    
    public var wrappedValue: T?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode<T>(T.self) {
            self.wrappedValue = value
        } else if let value = try? container.decode(String.self) {
            self.wrappedValue = T.init(value)
        } else if let value = try? container.decode(Int.self) {
            self.wrappedValue = T.init(String(describing: value))
        } else if let value = try? container.decode(UInt.self) {
            self.wrappedValue = T.init(String(describing: value))
        } else if let value = try? container.decode(Float.self) {
            self.wrappedValue = T.init(String(describing: value))
        } else if let value = try? container.decode(Double.self) {
            self.wrappedValue = T.init(String(describing: value))
        } else if let value = try? container.decode(Bool.self) {
            self.wrappedValue = T.init(String(describing: value))
        } else if let value = try? container.decode(Int64.self) {
            self.wrappedValue = T.init(String(describing: value))
        } else if let value = try? container.decode(UInt64.self) {
            self.wrappedValue = T.init(String(describing: value))
        } else {
            self.wrappedValue = nil
            if Hollow.Logger.logIfNeeded {
                let err = DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to convert an instance of \(T.self)")
                Hollow.Logger.logDebug(err)
            }
        }
    }
}

@propertyWrapper public struct AnyBackedEncoding<T: StringRepresentable>: Encodable {
    
    public let wrappedValue: T?
    
    public init(_ wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let wrappedValue = wrappedValue {
            try container.encode(wrappedValue.description)
        } else {
            try container.encodeNil()
        }
    }
}
