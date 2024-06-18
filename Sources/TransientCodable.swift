//
//  TransientCodable.swift
//  HollowCodable
//
//  Created by Condy on 2024/6/1.
//

import Foundation

@propertyWrapper public struct TransientCoding<T: Codable>: TransientCodable {
    public var wrappedValue: T
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

@propertyWrapper public struct TransientEncoding<T: Codable>: TransientEncodable {
    public var wrappedValue: T
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

@propertyWrapper public struct TransientDecoding<T: Codable>: TransientDecodable {
    public var wrappedValue: T
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

public protocol TransientEncodable: Encodable {
    associatedtype ValueType: Encodable
    // The value to be encoded
    var wrappedValue: ValueType { get }
}

public extension TransientEncodable {
    // Encodes the wrapped value directly at the current level
    func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

public protocol TransientDecodable: Decodable {
    associatedtype InitType: Decodable
    // The init to use when decoding
    init(wrappedValue: InitType)
}

public extension TransientDecodable {
    // Decodes the value directly at the current level of encoding
    init(from decoder: Decoder) throws {
        self.init(wrappedValue: try InitType(from: decoder))
    }
}

public protocol TransientCodable: TransientEncodable, TransientDecodable where ValueType == InitType { }

extension TransientEncoding: Decodable where T: Decodable {
    // Ensures there isn't an extra level added
    public init(from decoder: Decoder) throws {
        wrappedValue = try T(from: decoder)
    }
}

extension TransientDecoding: Encodable where T: Encodable {
    // Ensures there isn't an extra level added
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension TransientEncoding: Equatable where T: Equatable { }
extension TransientDecoding: Equatable where T: Equatable { }
extension TransientCoding: Equatable where T: Equatable { }
