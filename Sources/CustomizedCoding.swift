//
//  CustomizedCoding.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public protocol Customizedable: Codable {
    associatedtype ValueType
    func toValue() -> ValueType?
    static func create(with value: ValueType) throws -> Self
}

/// Custom property wrapper, use can refer to `RGBACoding`
@propertyWrapper public struct CustomizedCoding<T: Customizedable>: Codable {
    
    public var wrappedValue: T.ValueType?
    
    public init(_ wrappedValue: T.ValueType?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try CustomizedDecoding<T>(from: decoder).wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try CustomizedEncoding<T>(wrappedValue).encode(to: encoder)
    }
}

@propertyWrapper public struct CustomizedDecoding<T: Customizedable>: Decodable {
    
    public var wrappedValue: T.ValueType?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let value = try? container.decode<T>(T.self) else {
            self.wrappedValue = nil
            if Hollow.Logger.logIfNeeded {
                let error = DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Failed to convert an instance of \(T.self) from \(container.codingPath.last!.stringValue)"
                )
                Hollow.Logger.logDebug(error)
            }
            return
        }
        self.wrappedValue = value.toValue()
    }
}

@propertyWrapper public struct CustomizedEncoding<T: Customizedable>: Encodable {
    
    public let wrappedValue: T.ValueType?
    
    public init(_ wrappedValue: T.ValueType?) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = self.wrappedValue {
            try container.encode(T.create(with: value))
        } else {
            try container.encodeNil()
        }
    }
}
