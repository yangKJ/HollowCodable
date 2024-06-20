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
    
    public init(_ wrappedValue: T.DecodeType) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try DefaultBackedDecoding<T>(from: decoder).wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try DefaultBackedEncoding<T>(wrappedValue).encode(to: encoder)
    }
}

@propertyWrapper public struct DefaultBackedDecoding<T: Transformer>: Decodable where T: HasDefaultValuable, T.DefaultType == T.DecodeType {
    
    public var wrappedValue: T.DecodeType
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try AnyBackedDecoding<T>.init(from: decoder).wrappedValue ?? T.hasDefaultValue
    }
}

@propertyWrapper public struct DefaultBackedEncoding<T: Transformer>: Encodable {
    
    public let wrappedValue: T.DecodeType
    
    public init(_ wrappedValue: T.DecodeType) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try AnyBackedEncoding<T>(wrappedValue).encode(to: encoder)
    }
}
