//
//  DefaultBacked.swift
//  CodableExample
//
//  Created by Condy on 2024/6/16.
//

import Foundation

public typealias DefaultBackedCoding<T: Transformer> = DefaultBacked<T> where T: HasDefaultValuable, T.DefaultType == T.DecodeType

@propertyWrapper public struct DefaultBacked<T: Transformer>: Codable where T: HasDefaultValuable, T.DefaultType == T.DecodeType {
    
    public var wrappedValue: T.DecodeType
    
    @inline(__always) public init(_ wrappedValue: T.DecodeType? = nil) {
        self.wrappedValue = wrappedValue ?? T.hasDefaultValue
    }
    
    @inline(__always) public init(from decoder: Decoder) throws {
        self.wrappedValue = try DefaultBackedDecoding<T>(from: decoder).wrappedValue
    }
    
    @inline(__always) public func encode(to encoder: Encoder) throws {
        try DefaultBackedEncoding<T>(wrappedValue).encode(to: encoder)
    }
}

@propertyWrapper public struct DefaultBackedDecoding<T: Transformer>: Decodable where T: HasDefaultValuable, T.DefaultType == T.DecodeType {
    
    public var wrappedValue: T.DecodeType
    
    @inline(__always) public init(from decoder: Decoder) throws {
        self.wrappedValue = try AnyBackedDecoding<T>.init(from: decoder).wrappedValue ?? T.hasDefaultValue
    }
}

@propertyWrapper public struct DefaultBackedEncoding<T: Transformer>: Encodable where T: HasDefaultValuable, T.DefaultType == T.DecodeType {
    
    public let wrappedValue: T.DecodeType?
    
    @inline(__always) public init(_ wrappedValue: T.DecodeType? = nil) {
        self.wrappedValue = wrappedValue
    }
    
    @inline(__always) public func encode(to encoder: Encoder) throws {
        let value = wrappedValue ?? T.hasDefaultValue
        try AnyBackedEncoding<T>(value).encode(to: encoder)
    }
}
