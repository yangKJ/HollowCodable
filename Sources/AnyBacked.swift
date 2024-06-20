//
//  AnyBacked.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

public typealias AnyBackedCoding<T: Transformer> = AnyBacked<T>

@propertyWrapper public struct AnyBacked<T: Transformer>: Codable {
    
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

@propertyWrapper public struct AnyBackedDecoding<T: Transformer>: Decodable {
    
    public var wrappedValue: T.DecodeType?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let loggerDataCorruptedError = {
            if Hollow.Logger.logIfNeeded == false {
                return
            }
            let err = DecodingError.dataCorruptedError(in: container, debugDescription: "Failed to convert an instance of \(T.DecodeType.self)")
            Hollow.Logger.logDebug(err)
        }
        if container.decodeNil() {
            self.wrappedValue = nil
            loggerDataCorruptedError()
            return
        }
        if let value = try? container.decode<T>(T.self) {
            self.wrappedValue = try value.transform()
        } else if let value = try? container.decode(String.self) {
            self.wrappedValue = try T.init(value)?.transform()
        } else if let value = try? container.decode(Int.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(UInt.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Float.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Double.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(CGFloat.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Bool.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(Int64.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else if let value = try? container.decode(UInt64.self) {
            self.wrappedValue = try T.init(String(describing: value))?.transform()
        } else {
            self.wrappedValue = nil
            loggerDataCorruptedError()
        }
    }
}

@propertyWrapper public struct AnyBackedEncoding<T: Transformer>: Encodable {
    
    public let wrappedValue: T.DecodeType?
    
    public init(_ wrappedValue: T.DecodeType?) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = self.wrappedValue {
            if let value = try? T.transform(from: value) {
                try container.encode(value)
            } else {
                try container.encodeNil()
            }
        } else {
            try container.encodeNil()
        }
    }
}
