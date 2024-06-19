//
//  AnyBacked.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public typealias AnyBackedCoding<T: AnyBackedable> = AnyBacked<T>

@propertyWrapper public struct AnyBacked<T: AnyBackedable>: Codable {
    
    public var wrappedValue: T.DecodeType?
    
    public init(_ wrappedValue: T.DecodeType?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = try AnyBackedDecoding<T>(from: decoder).wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        try AnyBackedEncoding<T>(wrappedValue).encode(to: encoder)
    }
}

@propertyWrapper public struct AnyBackedDecoding<T: AnyBackedable>: Decodable {
    
    public var wrappedValue: T.DecodeType?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode<T>(T.self) {
            self.wrappedValue = value.toDecodeValue()
        } else if let value = try? container.decode(String.self) {
            self.wrappedValue = T.init(value)?.toDecodeValue()
        } else if let value = try? container.decode(Int.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else if let value = try? container.decode(UInt.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else if let value = try? container.decode(Float.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else if let value = try? container.decode(Double.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else if let value = try? container.decode(CGFloat.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else if let value = try? container.decode(Bool.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else if let value = try? container.decode(Int64.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else if let value = try? container.decode(UInt64.self) {
            self.wrappedValue = T.init(String(describing: value))?.toDecodeValue()
        } else {
            self.wrappedValue = nil
            if Hollow.Logger.logIfNeeded {
                let err = DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to convert an instance of \(T.DecodeType.self)")
                Hollow.Logger.logDebug(err)
            }
        }
    }
}

@propertyWrapper public struct AnyBackedEncoding<T: AnyBackedable>: Encodable {
    
    public let wrappedValue: T.DecodeType?
    
    public init(_ wrappedValue: T.DecodeType?) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = self.wrappedValue {
            let obj = try T.create(with: value)
            if let string = obj.toEncodeVaule() {
                try container.encode(string)
            } else {
                try container.encode(obj)
            }
        } else {
            try container.encodeNil()
        }
    }
}
